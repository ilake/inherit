# == Schema Information
# Schema version: 20100823122919
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  facebook_uid         :integer(8)
#  facebook_session_key :string(149)
#  created_at           :datetime
#  updated_at           :datetime
#  username             :string(255)
#  fans_count           :integer(4)      default(0)
#  admin                :boolean(1)
#  user_ifollow_count   :integer(4)      default(0)
#  nickname             :string(255)
#

class User < ActiveRecord::Base
  acts_as_voter
  acts_as_tagger
  acts_as_fannable

  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
    :rememberable, :trackable, :validatable, :facebook_connectable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :username, :password_confirmation, :nickname, :profile_attributes

  validates_presence_of :username
  validates_uniqueness_of :username

  validates_presence_of :email, :if => Proc.new{|u| u.facebook_uid.nil?  }, :on => :create
  validates_presence_of :email, :on => :update
  validates_uniqueness_of :email, :allow_nil => true, :on => :create
  validates_uniqueness_of :email, :on => :update

  validates_uniqueness_of :nickname, :on => :update
  validates_presence_of :nickname, :on => :update

  validates_length_of :username, :maximum => 10
  #限定只能用英文
  validates_format_of :username, :with => /\A[a-z0-9]+\Z/i, :on => :create, :message => '必須是英文或數字'

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile, :allow_destroy => true

  has_many :goals
  has_many :experiences
  has_many :comments
  has_many :questions

  has_many :leave_chats, :class_name => 'Chat', :foreign_key => :user_id
  has_many :own_chats, :class_name => 'Chat', :foreign_key => :master_id

  delegate :location_list, :birthday, :intro, :locale, :to => :profile

  after_create :init
#  validate_on_update do |u|
#    u.errors.add(:nickname, '暱稱不能有空白') if  u.nickname.match(/\s/)
#  end

  def to_param
    "#{id}-#{username}"
  end

  def is_not_guest?
    !!id
  end

  def is_guest?
    !id
  end

  def is_owner?(current_user)
    @is_owner ||= self == current_user
  end

  def user_fans
    user_ids = self.fans.map{|f| f.user_id }
    User.find(:all, :conditions => {:id => user_ids }, :include => 'profile')
  end

  def ifollow
    user_ids = Fan.find(:all, :conditions => {:user_id => self.id, :fannable_type => 'User'}).map{|f| f.fannable_id}
    User.find(:all, :conditions => {:id => user_ids })
  end

  def before_facebook_connect(fb_session)
    fb_session.user.populate(:username, :name)

    fb_username = fb_session.user.username
    fb_nickname = fb_session.user.name
    self.username = (fb_username || fb_nickname)
    self.nickname = (fb_nickname || fb_username)
  end

  def after_facebook_connect(fb_session)
    #...
  end

  #Facebook connect user maybe wrong
  def init_user_email_username
    self.invalid? && (self.errors.on(:email) || self.errors.on(:username))
  end

  def is_facebook_user?
    !!self.facebook_uid
  end

  def showname
    @showname ||= (nickname || username)
  end

  #想幫他產生預設的生日, 到今天的日子, 遇到我們的日子
  def init_exp_data
    self.experiences.create([
        {
      :content => "#{self.showname} #{I18n.t("init.birthday", :locale => self.locale)}",
      :start_at => self.birthday,
      :tag_list => I18n.t('init.birthday_tags', :locale => self.locale),
      :public => false
    },
      {
      :content => "#{self.showname} #{I18n.t("init.life_until_now", :locale => self.locale)}",
      :start_at => self.birthday,
      :end_at => Time.now,
      :tag_list => I18n.t("init.life_until_now_tags", :locale => self.locale),
      :until_now => true,
      :public => false
    },
      {
      :content =>  "#{self.showname} #{I18n.t("init.meet_us", :locale => self.locale)}",
      :start_at => Time.now,
      :tag_list => I18n.t("init.meet_us_tags", :locale => self.locale),
      :public => false
    }
    ])
  end

  def deliver_goal_empty_notification
    Delayed::Job.enqueue(GoalEmptyMailingJob.new(self.id))
  end

  def deliver_exp_empty_notification
    Delayed::Job.enqueue(ExpEmptyMailingJob.new(self.id))
  end

  private
  def init
    self.create_profile
  end

end


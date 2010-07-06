# == Schema Information
# Schema version: 20100706101940
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
#  created_at           :datetime
#  updated_at           :datetime
#  fans_count           :integer(4)      default(0)
#  admin                :boolean(1)
#  user_ifollow_count   :integer(4)      default(0)
#  username             :string(255)
#  nickname             :string(255)
#

class User < ActiveRecord::Base
  acts_as_voter
  acts_as_tagger
  acts_as_fannable

  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :username, :password_confirmation, :nickname, :profile_attributes

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

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
  has_many :chats

  delegate :location_list, :birthday, :to => :profile

  after_create :init
  validate_on_update do |u|
    u.errors.add(:nickname, '暱稱不能有空白') if  u.nickname.match(/\s/)
  end


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
    User.find(:all, :conditions => {:id => user_ids })
  end

  def ifollow
    user_ids = Fan.find(:all, :conditions => {:user_id => self.id, :fannable_type => 'User'}).map{|f| f.fannable_id}
    User.find(:all, :conditions => {:id => user_ids })
  end

  private
  def init
    self.create_profile
  end

end

# == Schema Information
# Schema version: 20100531043838
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
#  username             :string(255)
#

class User < ActiveRecord::Base
  acts_as_voter
  acts_as_tagger

  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :username, :password_confirmation

  validates_presence_of :username
  validates_uniqueness_of :username

  has_one :profile, :dependent => :destroy

  has_many :goals
  has_many :experiences
  has_many :comments

  delegate :location_list, :birthday, :to => :profile

  after_create :init

  def to_param
    "#{id}-#{username}"
  end

  def is_not_guest?
    !!id
  end

  def is_guest?
    !id
  end

  private
  def init
    self.create_profile
  end

end

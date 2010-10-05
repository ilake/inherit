# == Schema Information
# Schema version: 20101004155754
#
# Table name: chats
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  parent_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  master_id  :integer(4)
#

# master_id 是 nil 表示是寄給 admin
class Chat < ActiveRecord::Base
  attr_accessible :content, :parent_id, :location_list, :master_id, :user_id
  validates_presence_of :user_id, :content

  default_scope :order => 'created_at DESC'
  named_scope :origin, :conditions => {:parent_id => nil}
  named_scope :for_admin, :conditions => {:master_id => nil}
  acts_as_tree
  acts_as_taggable_on :locations

  belongs_to :user
  belongs_to :owner, :class_name => 'User', :foreign_key => "master_id"

  before_create :default_set_user_location
  after_create :deliver_chat_notification, :if => Proc.new{|c| c.parent_id }
  
  #如果是給一般使用者的留言就寄信, admin不用
  after_create :deliver_master_chat_notification, :if => Proc.new{|c| c.parent_id.nil? && !c.to_admin? }

  def self.location_with(location)
    if location == 'World' || location.blank?
      scope = Chat.scoped({:include => :user})
    else
      tagged_with(location, :on => :locations)
    end
  end

  def to_admin?
    !master_id
  end

  def reply_permission(current_user)
    if self.owner
      self.owner == current_user
    else
      current_user.try(:admin)
    end
  end

  private
  def deliver_chat_notification
    #回應發給發問者
    Delayed::Job.enqueue(ChatMailingJob.new(self.id))
  end

  def deliver_master_chat_notification
    #留言給作者
    Delayed::Job.enqueue(ChatMasterMailingJob.new(self.id))
  end

  def default_set_user_location
    self.location_list = self.user.location_list
  end
end


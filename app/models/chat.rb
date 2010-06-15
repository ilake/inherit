# == Schema Information
# Schema version: 20100615163218
#
# Table name: chats
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  parent_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Chat < ActiveRecord::Base
  attr_accessible :content, :parent_id
  validates_presence_of :user_id, :content

  default_scope :order => 'created_at DESC'
  named_scope :origin, :conditions => {:parent_id => nil}
  acts_as_tree

  belongs_to :user

  after_create :deliver_chat_notification

  private
  def deliver_chat_notification
    #回應發給發問者
    Delayed::Job.enqueue(ChatMailingJob.new(self.id)) if self.parent
  end
end

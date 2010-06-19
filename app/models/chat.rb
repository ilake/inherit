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
  attr_accessible :content, :parent_id, :location_list
  validates_presence_of :user_id, :content

  default_scope :order => 'created_at DESC'
  named_scope :origin, :conditions => {:parent_id => nil}
  acts_as_tree
  acts_as_taggable_on :locations

  belongs_to :user

  after_create :deliver_chat_notification

  def self.location_with(location)
    if location == 'World' || location.blank?
      scope = Chat.scoped({:include => :user})
    else
      tagged_with(location, :on => :locations)
    end
  end

  private
  def deliver_chat_notification
    #回應發給發問者
    Delayed::Job.enqueue(ChatMailingJob.new(self.id)) if self.parent
  end

  def default_set_user_location
    self.location_list = self.user.location_list
  end
end

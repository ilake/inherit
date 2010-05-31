# == Schema Information
# Schema version: 20100531043838
#
# Table name: experiences
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#  goal_id    :integer(4)
#  exp_type   :string(255)     default("normal")
#  until_now  :boolean(1)
#

class Experience < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  acts_as_commentable
  acts_as_voteable
  attr_accessible :start_at, :end_at, :content, :goal_id, :tag_list, :exp_type, :location_list, :until_now, :end_at_exist

  belongs_to :user
  belongs_to :goal

  validates_presence_of :user_id, :content

  before_create :default_set_user_location

  def default_set_user_location
    self.location_list = self.user.location_list
  end

  def self.location_with(location)
    if location == 'World' || location.blank?
      scope = Experience.scoped({:include => :user})
    else
      tagged_with(location, :on => :locations)
    end
  end

  def end_at_exist=(value)
    if value == '0'
      self.end_at = nil
    end
  end

  def end_at_exist
    !!end_at
  end

  def end_at_hash
    if self.until_now 
      {'end' => Time.now.to_s(:date)}
    elsif !self.end_at_exist || self.start_at.to_s(:date) == self.end_at.to_s(:date) 
      {}
    else
      {'end' => self.end_at.to_s(:date)}
    end
  end

  def end_at_date
    if self.until_now
      Time.now.to_s(:date)
    elsif end_at
      self.end_at.to_s(:date)
    end
  end

end

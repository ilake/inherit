# == Schema Information
# Schema version: 20100516132734
#
# Table name: experiences
#
#  id         :integer         not null, primary key
#  content    :text
#  user_id    :integer
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#  goal_id    :integer
#  exp_type   :string(255)     default("normal")
#

class Experience < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  acts_as_commentable
  acts_as_voteable
  attr_accessible :start_at, :end_at, :content, :goal_id, :tag_list, :exp_type, :location_list

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

end

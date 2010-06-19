# == Schema Information
# Schema version: 20100607231917
#
# Table name: questions
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  attr_accessible :title, :content, :location_list
  acts_as_commentable
  acts_as_taggable_on :locations

  belongs_to :user
  has_many :question_experience_relations, :dependent => :destroy
  has_many :experiences, :through => :question_experience_relations, :source => :experience

  validates_presence_of :title, :content

  before_create :default_set_user_location

  def to_param
    "#{id}-#{title}"
  end

  def self.location_with(location)
    if location == 'World' || location.blank?
      scope = Question.scoped
    else
      tagged_with(location, :on => :locations)
    end
  end

  private
  def default_set_user_location
    self.location_list = self.user.location_list
  end
end

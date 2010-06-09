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
  attr_accessible :title, :content
  acts_as_commentable

  belongs_to :user
  has_many :question_experience_relations
  has_many :experiences, :through => :question_experience_relations, :source => :experience

  validates_presence_of :title, :content

  def to_param
    "#{id}-#{title}"
  end
end

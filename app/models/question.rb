# == Schema Information
# Schema version: 20101004155754
#
# Table name: questions
#
#  id                :integer(4)      not null, primary key
#  title             :string(255)
#  content           :text
#  user_id           :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#  comments_count    :integer(4)      default(0)
#  last_comment_time :datetime
#  tags_list         :string(255)
#

class Question < ActiveRecord::Base
  include TagListFunc

  attr_accessible :title, :content, :location_list, :tag_list
  acts_as_commentable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  belongs_to :user
  has_many :question_experience_relations, :dependent => :destroy
  has_many :experiences, :through => :question_experience_relations, :source => :experience

  validates_presence_of :title, :content

  before_create :set_last_comment_time

  define_index do
    indexes content
    indexes title
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/\s/i, '-')}"
  end
  private

  def set_last_comment_time
    self.last_comment_time = Time.now
  end

end

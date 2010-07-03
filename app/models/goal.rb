# == Schema Information
# Schema version: 20100620155656
#
# Table name: goals
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)     default("")
#  content    :text
#  state      :string(10)      default("working")
#  user_id    :integer(4)
#  start_at   :time
#  end_at     :time
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean(1)      default(TRUE)
#  tags_list  :text
#

class Goal < ActiveRecord::Base
  include TagListFunc

  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations
  acts_as_commentable
  attr_accessible :start_at, :title, :content, :state, :tag_list, :public, :location_list

  belongs_to :user
  has_many :experiences

  validates_presence_of :content, :title, :start_at

  define_index do
    indexes content
    indexes title
    indexes tags_list
    where "public = '1'"
    group_by "user_id"
  end

  def to_param
    "#{id}-#{title}"
  end

end

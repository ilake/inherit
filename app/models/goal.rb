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
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations
  attr_accessible :start_at, :title, :content, :state, :tag_list, :public, :location_list

  belongs_to :user
  has_many :experiences

  validates_presence_of :content, :title, :start_at
  before_save :set_tags_list
  before_create :default_set_user_location


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

  private
  def set_tags_list
    self.tags_list = tag_list.join(" ")
  end

  def default_set_user_location
    self.location_list = self.user.location_list
  end

end

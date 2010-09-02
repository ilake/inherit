# == Schema Information
# Schema version: 20100823122919
#
# Table name: goals
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)     default("")
#  content    :text
#  state      :string(10)      default("working")
#  user_id    :integer(4)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean(1)      default(TRUE)
#  tags_list  :text
#  category   :string(255)     default("category")
#  percentage :integer(4)      default(0)
#

class Goal < ActiveRecord::Base
  include TagListFunc

  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations
  acts_as_commentable
  attr_accessible :start_at, :title, :content, :state, :tag_list, :public, :location_list, :category, :end_at, :percentage

  belongs_to :user
  has_many :experiences

  validates_presence_of :content, :title, :tag_list
  validates_uniqueness_of :title, :scope => :user_id
  named_scope :not_category, :conditions => "start_at is not NULL"
  named_scope :is_category, :conditions => "start_at is NULL"
  named_scope :state_is, lambda{|state|{:conditions => {:state => state}}}

  define_index do
    indexes content
    indexes title
    indexes tags_list
    where "public = '1'"
    group_by "user_id"
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/\s/i, '-')}"
  end

  def is_category?
    !start_at
  end

  def tab_style
    self.is_category? ? nil : {:class => 'goal_tab'}
  end

  def find_related_goals(current_user_location)
     result = Goal.search self.tag_list.rand, :limit => 6 
     result = (result.blank? || result == [nil]) ? Goal.location_with(current_user_location).descend_by_updated_at.limit(6).all : result
     result.delete(self)
     return result
  end


#  def end_at_exist
#    !!end_at
#  end
#
#  def end_at_hash
#    if self.state == 'working'
#      {'end' => Time.now.to_s(:date)}
#    elsif !self.end_at_exist || self.start_at > self.end_at
#      {}
#    else
#      {'end' => self.end_at.to_s(:date)}
#    end
#  end


end


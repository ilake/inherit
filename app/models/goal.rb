# == Schema Information
# Schema version: 20100516074048
#
# Table name: goals
#
#  id         :integer         not null, primary key
#  title      :text            default("New Goal")
#  content    :text            default("")
#  state      :string(10)      default("working")
#  user_id    :integer
#  start_at   :time
#  end_at     :time
#  created_at :datetime
#  updated_at :datetime
#

class Goal < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  attr_accessible :start_at, :title, :content, :state, :tag_list

  belongs_to :user
  has_many :experiences

  validates_presence_of :content, :title
end

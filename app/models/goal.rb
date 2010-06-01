# == Schema Information
# Schema version: 20100601034013
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
#

class Goal < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  attr_accessible :start_at, :title, :content, :state, :tag_list, :public

  belongs_to :user
  has_many :experiences

  validates_presence_of :content, :title

  def to_param
    "#{id}-#{title}"
  end

end

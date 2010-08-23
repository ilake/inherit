# == Schema Information
# Schema version: 20100818063426
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
#  public     :boolean(1)      default(TRUE)
#  tags_list  :text
#  color      :string(7)       default("#64E827")
#  position   :integer(4)      default(0)
#

require 'spec_helper'

describe Experience do
  before(:each) do
    @valid_attributes = {
      :content => "value for content"
    }
  end

  it "should create a new instance given valid attributes" do
    Experience.create!(@valid_attributes)
  end
end


# == Schema Information
# Schema version: 20101007045654
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
#  category   :string(255)     default("goal")
#  percentage :integer(4)      default(0)
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Goal do
  it "should be valid" do
    Goal.new.should be_valid
  end
end


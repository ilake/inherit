# == Schema Information
# Schema version: 20100816003850
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

require File.dirname(__FILE__) + '/../spec_helper'

describe Question do
  it "should be valid" do
    Question.new.should be_valid
  end
end


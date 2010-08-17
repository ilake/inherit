# == Schema Information
# Schema version: 20100816003850
#
# Table name: chats
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  parent_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  master_id  :integer(4)
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Chat do
  it "should be valid" do
    Chat.new.should be_valid
  end
end


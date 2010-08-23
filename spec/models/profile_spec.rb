# == Schema Information
# Schema version: 20100818063426
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  birthday   :date
#  gender     :boolean(1)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  intro      :text
#  tags_list  :text
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Profile do
  it "should be valid" do
    Profile.new.should be_valid
  end
end


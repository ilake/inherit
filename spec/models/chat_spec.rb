require File.dirname(__FILE__) + '/../spec_helper'

describe Chat do
  it "should be valid" do
    Chat.new.should be_valid
  end
end

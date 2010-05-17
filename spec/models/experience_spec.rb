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

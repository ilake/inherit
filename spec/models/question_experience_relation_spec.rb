require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionExperienceRelation do
  it "should be valid" do
    QuestionExperienceRelation.new.should be_valid
  end
end

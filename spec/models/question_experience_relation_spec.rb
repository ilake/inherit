# == Schema Information
# Schema version: 20101007045654
#
# Table name: question_experience_relations
#
#  id            :integer(4)      not null, primary key
#  question_id   :integer(4)
#  experience_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionExperienceRelation do
  it "should be valid" do
    QuestionExperienceRelation.new.should be_valid
  end
end


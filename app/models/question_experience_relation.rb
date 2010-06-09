class QuestionExperienceRelation < ActiveRecord::Base
  attr_accessible :question_id, :experience_id

  belongs_to :question
  belongs_to :experience
end

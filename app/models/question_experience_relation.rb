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

class QuestionExperienceRelation < ActiveRecord::Base
  attr_accessible :question_id, :experience_id

  belongs_to :question
  belongs_to :experience

  after_create :deliver_question_notification
  validates_uniqueness_of :question_id, :scope => :experience_id

  def mail_receiver
    #分給它過experience的
    experience_ids = QuestionExperienceRelation.find(:all, :conditions => {:question_id => self.question_id}).map{|q| q.experience_id}

    receiver_ids = Experience.find(:all, :conditions => {:id => experience_id}).map{|e| e.user_id}

    #question 的擁有者
    receiver_ids << self.question.user_id
    receiver_ids.uniq!

    #扣掉本筆comment的擁有者
    receiver_ids.delete(self.experience.user_id)

    users = User.find(:all, :conditions => {:id => receiver_ids})
  end

  private
  def deliver_question_notification
    Delayed::Job.enqueue(QuestionMailingJob.new(self.id))
  end
end

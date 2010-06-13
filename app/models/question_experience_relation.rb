class QuestionExperienceRelation < ActiveRecord::Base
  attr_accessible :question_id, :experience_id

  belongs_to :question
  belongs_to :experience

  after_create :deliver_question_notification

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

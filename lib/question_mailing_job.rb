class QuestionMailingJob < Struct.new(:que_exp_id)
  def perform
    que_exp_rel = QuestionExperienceRelation.find(que_exp_id)
    NotificationMailer.deliver_question_notification(que_exp_rel.mail_receiver, que_exp_rel.experience)
  end
end

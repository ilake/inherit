class ExperienceMailingJob < Struct.new(:exp_id, :user_id)
  def perform
    NotificationMailer.deliver_experience_notification(User.find(user_id).user_fans, Experience.find(exp_id))
  end
end

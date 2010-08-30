class GoalEmptyMailingJob < Struct.new(:user_id)
  def perform
    NotificationMailer.deliver_goal_empty(User.find(user_id))
  end
end

class ExpEmptyMailingJob < Struct.new(:user_id)
  def perform
    user = User.find(user_id)
    NotificationMailer.deliver_exp_empty(user, user.goals.map{|g| g.title}, user.fans_count)
  end
end

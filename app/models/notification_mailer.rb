class NotificationMailer < ActionMailer::Base
  
  def comment_notification(user, comment)
    recipients    user.email
    from          "notifications@inherit.com"
    subject       "Inherit Comment Notification"
    sent_on       Time.now
    @body.merge!({:user => user, :comment => comment})
  end

end

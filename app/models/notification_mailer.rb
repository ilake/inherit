class NotificationMailer < ActionMailer::Base

  def comment_notification(users, comment)
    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Comment Notification"
    sent_on       Time.now
    body          :comment => comment
  end

end

class NotificationMailer < ActionMailer::Base

  def comment_notification(users, comment)
    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Comment Notification"
    sent_on       Time.now
    body          :comment => comment
  end

  def question_notification(users, experience)
    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Question Notification"
    sent_on       Time.now
    body          :experience => experience
  end
end
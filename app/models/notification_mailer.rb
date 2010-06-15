class NotificationMailer < ActionMailer::Base

  def chat_notification(user, chat, reply)
    bcc           user.email
    from          "notifications@inherit.com"
    subject       "Chat Comment Notification"
    sent_on       Time.now
    body          :chat => chat, :reply => reply
  end
  def comment_notification(users, comment)
    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Comment Notification"
    sent_on       Time.now
    body          :comment => comment
  end

  def question_notification(users, experience, question)
    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Question Notification"
    sent_on       Time.now
    body          :experience => experience, :question => question
  end

  def experience_notification(users, experience)
    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Experience Notification"
    sent_on       Time.now
    body          :experience => experience
  end
end

class NotificationMailer < ActionMailer::Base
  def load_settings
    @@smtp_settings = {
      :enable_starttls_auto => true,
      :address => "smtp.gmail.com",
      :port => "587",
      :domain => "localhost.localdomain",
      :authentication => :plain,
      :user_name => "iinherit#{rand(4)}@gmail.com",
      :password => "-pl,0okm9ijn"
    }
  end

  def chat_notification(user, chat, reply)
    load_settings

    bcc           user.email
    from          "notifications@inherit.com"
    subject       "Chat Comment Notification"
    sent_on       Time.now
    body          :chat => chat, :reply => reply
  end

  def comment_notification(users, comment)
    load_settings

    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Comment Notification"
    sent_on       Time.now
    body          :comment => comment
  end

  def question_notification(users, experience, question)
    load_settings

    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Question Notification"
    sent_on       Time.now
    body          :experience => experience, :question => question
  end

  def experience_notification(users, experience)
    load_settings

    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Experience Notification"
    sent_on       Time.now
    body          :experience => experience
  end

  def goal_empty(user)
    load_settings

    recipients     user.email
    from          "notifications@inherit.com"
    subject       "Empty goal Notification"
    sent_on       Time.now
    body          :user => user
  end

  def exp_empty(user, goals, fans_count)
    load_settings

    recipients     user.email
    from          "notifications@inherit.com"
    subject       "Empty exp Notification"
    sent_on       Time.now
    body          :user => user, :goals => goals, :fans_count => fans_count
  end
end

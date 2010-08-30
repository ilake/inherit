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

  def host
    @host_url ||= "http://#{ActionMailer::Base.default_url_options[:host]}"
  end

  def chat_notification(user, chat, reply)
    load_settings

    bcc           user.email
    from          "notifications@inherit.com"
    subject       "#{chat.owner.showname} #{I18n.t('mail.message_notify_subject', :locale => user.locale)}"
    sent_on       Time.now
    body          :chat => chat, :reply => reply, :user => user, :host => host, :url => user_chat_path(chat.owner, chat)
  end

  def comment_notification(users, comment)
    load_settings

    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "Inherit Comment Notification"
    sent_on       Time.now
    body          :comment => comment, :host => host, :url => url_for(comment.commentable)
  end

#  def question_notification(users, experience, question)
#    load_settings
#
#    bcc           users.map{|u| u.email}
#    from          "notifications@inherit.com"
#    subject       "Inherit Question Notification"
#    sent_on       Time.now
#    body          :experience => experience, :question => question
#  end

  def experience_notification(users, experience)
    load_settings

    bcc           users.map{|u| u.email}
    from          "notifications@inherit.com"
    subject       "#{experience.user.showname} Inherit Experience Notification"
    sent_on       Time.now
    body          :experience => experience, :host => host, :url => experience_path(experience)
  end

  def goal_empty(user)
    load_settings

    recipients     user.email
    from          "notifications@inherit.com"
    subject       "#{user.showname} #{I18n.t('mail.goal_empty_notify_subject', :locale => user.locale)}"
    sent_on       Time.now
    body          :user => user, :host => host, :host => host, :new_goal_url => new_goal_path, :home_url => home_path
  end

  def exp_empty(user, goals, fans_count)
    load_settings

    recipients     user.email
    from          "notifications@inherit.com"
    subject       "#{user.showname}  #{I18n.t('mail.exp_empty_notify_subject', :locale => user.locale)}"
    sent_on       Time.now
    body          :user => user, :goals => goals, :fans_count => fans_count, :host => host, :new_exp_url => new_experience_path
  end
end

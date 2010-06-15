class ChatMailingJob < Struct.new(:chat_id)
  def perform
    chat = Chat.find(chat_id)
    NotificationMailer.deliver_chat_notification(chat.parent.user, chat.parent, chat)
  end
end

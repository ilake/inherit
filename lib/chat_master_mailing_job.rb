class ChatMasterMailingJob < Struct.new(:chat_id)
  def perform
    chat = Chat.find(chat_id)
    NotificationMailer.deliver_chat_notification(chat.owner, chat, nil)
  end
end

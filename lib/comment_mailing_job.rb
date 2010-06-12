class CommentMailingJob < Struct.new(:comment_id)
  def perform
    comment = Comment.find(comment_id)
    NotificationMailer.deliver_comment_notification(comment.mail_receiver, comment)
  end
end

# == Schema Information
# Schema version: 20100818063426
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  title            :string(50)      default("")
#  comment          :text
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  user_id          :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you # want user to vote on the quality of comments.
  #acts_as_voteable
  
  # NOTE: Comments belong to a user
  belongs_to :user

  validates_presence_of :comment
  after_create :deliver_comment_notification
  after_create :add_question_comment_count

  def mail_receiver
    #下過comment的
    commenter_ids = Comment.find(:all, :conditions => {:commentable_id => self.commentable_id, :commentable_type => self.commentable_type}).map{|c| c.user_id}
    #加入這筆comment 所要談論object 的擁有者
    commenter_ids << self.commentable.user_id
    commenter_ids.uniq!
    #扣掉本筆comment的擁有者
    commenter_ids.delete(self.user_id)

    users = User.find(:all, :conditions => {:id => commenter_ids})
  end

  private
  def deliver_comment_notification
    Delayed::Job.enqueue(CommentMailingJob.new(self.id))
  end

  def add_question_comment_count
    if self.commentable_type == 'Question'
      self.commentable.comments_count+=1
      self.commentable.last_comment_time = Time.now
      self.commentable.save!
    end
  end

end

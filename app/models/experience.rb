# == Schema Information
# Schema version: 20100816003850
#
# Table name: experiences
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#  goal_id    :integer(4)
#  exp_type   :string(255)     default("normal")
#  until_now  :boolean(1)
#  public     :boolean(1)      default(TRUE)
#  tags_list  :text
#  color      :string(7)       default("#64E827")
#  position   :integer(4)      default(0)
#

class Experience < ActiveRecord::Base
  include TagListFunc

  attr_accessible :start_at, :end_at, :content, :goal_id, :tag_list, :exp_type, :location_list, :until_now, :end_at_exist, :public, :color

  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  acts_as_commentable
  acts_as_voteable
  acts_as_list :scope => :user

  belongs_to :user
  belongs_to :goal

  has_many :question_experience_relations, :dependent => :destroy
  has_many :answer_questions, :through => :question_experience_relations, :source => :question

  validates_presence_of :user_id, :content

  #我想讓使用者寫文章時可以用顏色 所以先拿掉過濾
  #before_save :format_content
  after_create :deliver_experience_notification, :if => Proc.new{|exp| exp.public}
  
  #原本Private 變成public會在通知一次                                                    
  after_update :deliver_experience_notification, :if => Proc.new{|exp| exp.public_changed? && exp.public}

  named_scope :goal_categroy, Proc.new{|goal_id| 
    if goal_id
      {:conditions => {:goal_id => goal_id}}
    else
      {}
    end
  }
  named_scope :this_week, lambda{{:conditions => {:updated_at => Time.now.ago(7.days)..Time.now}}}
  named_scope :is_belong_one_goal, {:conditions => "goal_id is not NULL"}


  if respond_to? :define_index
    define_index do
      indexes content
      indexes tags_list
      #indexes comments.content, :as => 'comment_content'
      where "public = '1'"
      group_by "user_id"
    end
  end

  def end_at_exist=(value)
    if value == '0'
      self.end_at = nil
    end
  end

  def end_at_exist
    !!end_at
  end

  def end_at_hash
    if self.until_now 
      {'end' => Time.now.to_s(:date)}
    elsif !self.end_at_exist || self.start_at > self.end_at
      {}
    else
      {'end' => self.end_at.to_s(:date)}
    end
  end

  def end_at_date
    if self.until_now
      "~ #{Time.now.to_s(:date)}"
    elsif end_at
      "~ #{self.end_at.to_s(:date)}"
    end
  end

  def format_content
    write_attribute(:content, Sanitize.clean(CGI::unescapeHTML(content), Sanitize::Config::CUSTOM))
  end

  private
  def deliver_experience_notification
    Delayed::Job.enqueue(ExperienceMailingJob.new(self.id, self.user_id))
  end
end


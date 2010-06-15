# == Schema Information
# Schema version: 20100615130941
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
#

class Experience < ActiveRecord::Base
  attr_accessible :start_at, :end_at, :content, :goal_id, :tag_list, :exp_type, :location_list, :until_now, :end_at_exist, :public, :color

  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  acts_as_commentable
  acts_as_voteable

  belongs_to :user
  belongs_to :goal

  has_many :question_experience_relations, :dependent => :destroy
  has_many :answer_questions, :through => :question_experience_relations, :source => :question

  validates_presence_of :user_id, :content

  before_create :default_set_user_location
  before_save :set_tags_list
  before_save :format_content
  after_create :deliver_experience_notification

  named_scope :goal_categroy, Proc.new{|goal_id| 
    if goal_id
      {:conditions => {:goal_id => goal_id}}
    else
      {}
    end
  }


  define_index do
    indexes content
    indexes tags_list
    where "public = '1'"
    group_by "user_id"
  end

  def default_set_user_location
    self.location_list = self.user.location_list
  end

  def self.location_with(location)
    if location == 'World' || location.blank?
      scope = Experience.scoped({:include => :user})
    else
      tagged_with(location, :on => :locations)
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
      Time.now.to_s(:date)
    elsif end_at
      self.end_at.to_s(:date)
    end
  end

  def format_content
    write_attribute(:content, Sanitize.clean(CGI::unescapeHTML(content), Sanitize::Config::CUSTOM))
  end

  private
  def set_tags_list
    self.tags_list = tag_list.join(" ")
  end

  def deliver_experience_notification
    Delayed::Job.enqueue(ExperienceMailingJob.new(self.id, self.user_id)) if self.public
  end
end

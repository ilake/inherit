# == Schema Information
# Schema version: 20100606092954
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  birthday   :date
#  gender     :boolean(1)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  intro      :text
#  tags_list  :text
#

class Profile < ActiveRecord::Base
  include TagListFunc

  attr_accessible :birthday, :gender, :location_list, :intro, :tag_list

  acts_as_taggable_on :tags
  acts_as_taggable_on :locations

  belongs_to :user
  validates_presence_of :intro, :tag_list, :on => :update

  named_scope :age_range, Proc.new{|age_start_at, age_end_at|
    if age_start_at.blank? || age_end_at.blank?
      {}
    else
      {:conditions => ["birthday > ? AND birthday < ?", age_start_at, age_end_at]}
    end
  }

  define_index do 
    indexes intro
    indexes tags_list
    has birthday
    where "intro is not NULL"
  end

end

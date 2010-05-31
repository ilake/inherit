# == Schema Information
# Schema version: 20100531043838
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  birthday   :date
#  gender     :boolean(1)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  acts_as_taggable_on :locations

  attr_accessible :birthday, :gender, :location_list
  belongs_to :user
end

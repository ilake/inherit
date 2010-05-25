# == Schema Information
# Schema version: 20100518021948
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  birthday   :date
#  gender     :boolean
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  acts_as_taggable_on :locations

  attr_accessible :birthday, :gender, :location_list
  belongs_to :user
end

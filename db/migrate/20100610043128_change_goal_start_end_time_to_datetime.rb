class ChangeGoalStartEndTimeToDatetime < ActiveRecord::Migration
  def self.up
    change_column :goals, :start_at, :datetime
    change_column :goals, :end_at, :datetime
  end

  def self.down
  end
end

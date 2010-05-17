class AddColumnGoalIdToExperiences < ActiveRecord::Migration
  def self.up
    add_column :experiences, :goal_id, :integer, :default => nil
  end

  def self.down
    remove_column :experiences, :goal_id
  end
end

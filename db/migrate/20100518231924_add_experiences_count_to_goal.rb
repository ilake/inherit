class AddExperiencesCountToGoal < ActiveRecord::Migration
  def self.up
    add_column :goals, :experiences_count, :integer, :default => 0, :null => false
    execute "UPDATE goals SET experiences_count=(SELECT COUNT(*) FROM experiences WHERE goal_id=goals.id)"
  end

  def self.down
    remove_column :goals, :experiences_count
  end
end

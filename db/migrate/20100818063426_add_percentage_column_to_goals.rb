class AddPercentageColumnToGoals < ActiveRecord::Migration
  def self.up
    add_column :goals, :percentage, :integer, :default => 0
  end

  def self.down
    remove_column :goals, :percentage
  end
end

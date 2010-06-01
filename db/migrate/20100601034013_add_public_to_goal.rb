class AddPublicToGoal < ActiveRecord::Migration
  def self.up
    add_column :goals, :public, :boolean, :default => true
  end

  def self.down
    remove_column :goals, :public
  end
end

class AddCategoryToGoals < ActiveRecord::Migration
  def self.up
    add_column :goals, :category, :string, :default => 'goal'

    add_index :goals, :category
  end

  def self.down
    remove_column :goals, :category
  end
end

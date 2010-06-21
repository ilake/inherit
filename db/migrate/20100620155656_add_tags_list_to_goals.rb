class AddTagsListToGoals < ActiveRecord::Migration
  def self.up
    add_column :goals, :tags_list, :text
  end

  def self.down
    remove_column :goals, :tags_list
  end
end

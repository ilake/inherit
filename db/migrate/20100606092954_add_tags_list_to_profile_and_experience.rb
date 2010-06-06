class AddTagsListToProfileAndExperience < ActiveRecord::Migration
  def self.up
    add_column :profiles, :tags_list, :text, :default => ""
    add_column :experiences, :tags_list, :text, :default => ""
  end

  def self.down
    remove_column :profiles, :tags_list 
    remove_column :experiences, :tags_list
  end
end

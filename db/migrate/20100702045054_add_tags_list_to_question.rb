class AddTagsListToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :tags_list, :string
  end

  def self.down
    remove_column :questions, :tags_list
  end
end

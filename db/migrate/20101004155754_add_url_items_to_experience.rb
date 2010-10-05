class AddUrlItemsToExperience < ActiveRecord::Migration
  def self.up
    add_column :experiences, :url_title, :string, :default => '', :limit => 64
    add_column :experiences, :url_content, :text, :default => ''
    add_column :experiences, :url, :string, :default => ''
  end

  def self.down
    remove_column :experiences, :url_title, :string
    remove_column :experiences, :url_content, :text
    remove_column :experiences, :url, :string
  end
end

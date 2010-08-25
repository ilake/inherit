class AddLikeCountToUserAndLikeCountCommentCountToExperience < ActiveRecord::Migration
  def self.up
    add_column :users, :likes_count, :integer, :default => 0
    add_column :experiences, :likes_count, :integer, :default => 0
    add_column :experiences, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :likes_count
    remove_column :experiences, :likes_count
    remove_column :experiences, :comments_count
  end
end

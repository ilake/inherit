class AddCommentsCountLastCommentTimeToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :comments_count, :integer, :default => 0
    add_column :questions, :last_comment_time, :datetime

    add_index :questions, :last_comment_time
  end

  def self.down
    remove_column :questions, :comments_count
    remove_column :questions, :last_comment_time
  end
end

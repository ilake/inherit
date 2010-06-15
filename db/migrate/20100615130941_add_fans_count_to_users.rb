class AddFansCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :fans_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :fans_count
  end
end

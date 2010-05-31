class AddUntilNowToExperience < ActiveRecord::Migration
  def self.up
    add_column :experiences, :until_now, :boolean, :default => false
  end

  def self.down
    remove_column :experiences, :until_now
  end
end

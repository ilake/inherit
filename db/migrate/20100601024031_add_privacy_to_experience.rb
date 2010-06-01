class AddPrivacyToExperience < ActiveRecord::Migration
  def self.up
    add_column :experiences, :public, :boolean, :default => true
  end

  def self.down
    remove_column :experiences, :public
  end
end

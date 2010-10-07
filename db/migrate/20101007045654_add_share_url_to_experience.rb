class AddShareUrlToExperience < ActiveRecord::Migration
  def self.up
    add_column :experiences, :share_url, :string
    add_column :experiences, :share_expire_at, :datetime
  end

  def self.down
    remove_column :experiences, :share_url
    remove_column :experiences, :share_expire_at
  end
end

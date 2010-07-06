class AddNicknameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nickname, :string
    User.all.each do |u|
      u.update_attributes(:nickname => u.username)
    end
  end

  def self.down
    remove_column :users, :nickname
  end
end

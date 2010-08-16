class AddMasterIdColumnToChat < ActiveRecord::Migration
  def self.up
    add_column :chats, :master_id, :integer

    add_index :chats, :master_id
  end

  def self.down
    remove_column :chats, :master_id
  end
end

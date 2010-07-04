class CreateChats < ActiveRecord::Migration
  def self.up
    create_table :chats do |t|
      t.text :content
      t.belongs_to :user
      t.integer :parent_id
      t.timestamps
    end

    add_index :chats, :user_id
    add_index :chats, :created_at
  end
  
  def self.down
    drop_table :chats
  end
end

class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.date :birthday
      t.boolean :gender
      t.references :user
      t.timestamps
    end

    add_index :profiles, :user_id
  end
  
  def self.down
    drop_table :profiles
  end
end

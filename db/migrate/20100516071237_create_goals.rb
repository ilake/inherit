class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.string :title, :default => ""
      t.text :content, :default => ""
      t.string :state, :limit => 10, :default => "working"
      t.references :user
      t.time :start_at
      t.time :end_at
      t.timestamps
    end

    add_index :goals, :user_id
    add_index :goals, :start_at
  end
  
  def self.down
    drop_table :goals
  end
end

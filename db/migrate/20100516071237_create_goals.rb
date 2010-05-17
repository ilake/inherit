class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.text :title, :default => "New Goal"
      t.text :content, :default => ""
      t.string :state, :limit => 10, :default => "working"
      t.references :user
      t.time :start_at
      t.time :end_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :goals
  end
end

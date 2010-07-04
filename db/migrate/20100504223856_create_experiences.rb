class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.text :content
      t.belongs_to :user
      t.datetime :start_at, :end_at
      t.timestamps
    end

    add_index :experiences, :user_id
    add_index :experiences, :start_at
  end

  def self.down
    drop_table :experiences
  end
end

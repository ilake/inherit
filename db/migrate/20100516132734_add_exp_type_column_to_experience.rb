class AddExpTypeColumnToExperience < ActiveRecord::Migration
  def self.up
    add_column :experiences, :exp_type, :string, :default => 'normal'
  end

  def self.down
    remove_column :experiences, :exp_type
  end
end

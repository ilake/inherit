class AddColorToExperiences < ActiveRecord::Migration
  def self.up
    add_column :experiences, :color, :string, :default => '#64E827', :limit => 7
  end

  def self.down
    remove_column :experiences, :color
  end
end

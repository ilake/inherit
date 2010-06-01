class AddColumnIntroToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :intro, :text, :default => ""
  end

  def self.down
    remove_column :profiles, :intro
  end
end

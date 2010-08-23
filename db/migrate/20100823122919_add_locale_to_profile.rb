class AddLocaleToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :locale, :string, :default => 'en'
  end

  def self.down
    remove_column :profiles, :locale
  end
end

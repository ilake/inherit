class AddPositionToExperiences < ActiveRecord::Migration
  def self.up
    add_column :experiences, :position, :integer, :default => 0
    User.all.each do |u|
      u.experiences.find(:all, :order => "start_at ASC, created_at ASC").each_with_index { |e, i|
        e.update_attribute(:position, i+1)
      }
    end
  end

  def self.down
    remove_column :experiences, :position
  end
end

class AddMeritBadgesToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :meritbadge1, :integer
    add_column :campers, :meritbadge2, :integer
    add_column :campers, :meritbadge3, :integer
    add_column :campers, :meritbadge4, :integer
  end

  def self.down
    remove_column :campers, :meritbadge4
    remove_column :campers, :meritbadge3
    remove_column :campers, :meritbadge2
    remove_column :campers, :meritbadge1
  end
end

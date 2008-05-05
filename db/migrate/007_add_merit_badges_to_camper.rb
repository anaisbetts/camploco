class AddMeritBadgesToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :meritbadge0, :string
    add_column :campers, :meritbadge1, :string
    add_column :campers, :meritbadge2, :string
    add_column :campers, :meritbadge3, :string
  end

  def self.down
    remove_column :campers, :meritbadge3
    remove_column :campers, :meritbadge2
    remove_column :campers, :meritbadge1
    remove_column :campers, :meritbadge0
  end
end

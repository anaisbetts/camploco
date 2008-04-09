class AddTroopIdToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :troop_id, :integer
  end

  def self.down
    remove_column :campers, :troop_id
  end
end

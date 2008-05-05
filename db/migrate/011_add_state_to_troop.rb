class AddStateToTroop < ActiveRecord::Migration
  def self.up
    add_column :troops, :troopmaster_state, :string
  end

  def self.down
    remove_column :troops, :troopmaster_state
  end
end

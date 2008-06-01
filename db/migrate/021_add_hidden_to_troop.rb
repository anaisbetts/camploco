class AddHiddenToTroop < ActiveRecord::Migration
  def self.up
    add_column :troops, :hidden, :boolean
  end

  def self.down
    remove_column :troops, :hidden
  end
end

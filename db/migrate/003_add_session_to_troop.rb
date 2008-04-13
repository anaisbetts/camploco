class AddSessionToTroop < ActiveRecord::Migration
  def self.up
    add_column :troops, :session, :integer
  end

  def self.down
    remove_column :troops, :session
  end
end

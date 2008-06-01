class ChangeTroopNumberToString < ActiveRecord::Migration
  def self.up
    change_column :troops, :number, :string
  end

  def self.down
    change_column :troops, :number, :integer
  end
end

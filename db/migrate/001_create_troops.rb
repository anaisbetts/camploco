class CreateTroops < ActiveRecord::Migration
  def self.up
    create_table :troops do |t|
      t.integer :number
      t.string :troopmaster
      t.string :email
      t.string :identity_url

      t.timestamps
    end
  end

  def self.down
    drop_table :troops
  end
end

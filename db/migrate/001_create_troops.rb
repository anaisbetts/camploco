class CreateTroops < ActiveRecord::Migration
  def self.up
    create_table :troops do |t|
      t.string :identity_url

      t.string :troopmaster
      t.string :troopmaster_address
      t.string :troopmaster_city
      t.integer :troopmaster_zipcode
      t.string :troopmaster_email

      t.integer :number
      t.string :district
      t.string :council

      t.timestamps
    end
  end

  def self.down
    drop_table :troops
  end
end

class CreateCampers < ActiveRecord::Migration
  def self.up
    create_table :campers do |t|
      t.string :name
      t.string :rank
      t.integer :age
      t.boolean :nicoteh

      t.timestamps
    end
  end

  def self.down
    drop_table :campers
  end
end

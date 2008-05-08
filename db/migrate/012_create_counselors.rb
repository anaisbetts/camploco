class CreateCounselors < ActiveRecord::Migration
  def self.up
    create_table :counselors do |t|
      t.string :name
      t.string :merit_badge

      t.timestamps
    end
  end

  def self.down
    drop_table :counselors
  end
end

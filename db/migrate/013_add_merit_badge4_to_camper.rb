class AddMeritBadge4ToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :meritbadge4, :string
  end

  def self.down
    remove_column :campers, :meritbadge4
  end
end

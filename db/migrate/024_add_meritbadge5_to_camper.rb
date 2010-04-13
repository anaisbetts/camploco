class AddMeritbadge5ToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :meritbadge5, :string
  end

  def self.down
    remove_column :campers, :meritbadge5
  end
end

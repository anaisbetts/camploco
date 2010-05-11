class AddMeritbadge5BackupToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :meritbadge6, :string
  end

  def self.down
    remove_column :campers, :meritbadge6
  end
end

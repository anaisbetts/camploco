class AddMeritbadge5BackupToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :meritbadge5_backup, :string
  end

  def self.down
    remove_column :campers, :meritbadge5_backup
  end
end

class ChangeIdentityUrlToUserId < ActiveRecord::Migration
  def self.up
    remove_column :troops, :identity_url
    add_column :troops, :user_id, :int
  end

  def self.down
    remove_column :troops, :user_id
    add_column :troops, :identity_url, :string
  end
end

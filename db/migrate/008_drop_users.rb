class DropUsers < ActiveRecord::Migration
  def self.down
    create_table "users", :force => true do |t|
      t.column :identity_url,              :string
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
    end
  end

  def self.up
    drop_table "users"
  end
end

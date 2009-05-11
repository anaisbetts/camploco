class RemoveAuthStuff < ActiveRecord::Migration
  def self.up
    drop_table :open_id_authentication_associations
    drop_table :open_id_authentication_nonces
    drop_table :permissions
    drop_table :roles
    drop_table :users
  end

  def self.down
    create_table "open_id_authentication_associations", :force => true do |t|
      t.integer "issued"
      t.integer "lifetime"
      t.string  "handle"
      t.string  "assoc_type"
      t.binary  "server_url"
      t.binary  "secret"
    end

    create_table "open_id_authentication_nonces", :force => true do |t|
      t.integer "timestamp",  :null => false
      t.string  "server_url"
      t.string  "salt",       :null => false
    end

    create_table "permissions", :force => true do |t|
      t.integer  "role_id",    :null => false
      t.integer  "user_id",    :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "roles", :force => true do |t|
      t.string   "rolename"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "login"
      t.string   "email"
      t.string   "crypted_password",          :limit => 40
      t.string   "salt",                      :limit => 40
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.string   "activation_code",           :limit => 40
      t.datetime "activated_at"
      t.string   "password_reset_code",       :limit => 40
      t.boolean  "enabled",                                 :default => true
      t.string   "identity_url"
    end
  end
end

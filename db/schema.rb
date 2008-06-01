# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20) do

  create_table "campers", :force => true do |t|
    t.string   "name"
    t.integer  "age"
    t.boolean  "nicoteh"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "troop_id"
    t.string   "meritbadge0"
    t.string   "meritbadge1"
    t.string   "meritbadge2"
    t.string   "meritbadge3"
    t.string   "meritbadge4"
    t.string   "rank"
  end

  create_table "counselors", :force => true do |t|
    t.string   "name"
    t.string   "merit_badge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "troops", :force => true do |t|
    t.string   "troopmaster"
    t.string   "troopmaster_address"
    t.string   "troopmaster_city"
    t.string   "troopmaster_zipcode"
    t.string   "troopmaster_email"
    t.string   "number"
    t.string   "district"
    t.string   "council"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "session"
    t.string   "troopmaster_state"
    t.integer  "user_id"
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

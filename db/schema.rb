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

ActiveRecord::Schema.define(:version => 12) do

  create_table "campers", :force => true do |t|
    t.string   "name"
    t.string   "rank"
    t.integer  "age"
    t.boolean  "nicoteh"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "troop_id"
    t.string   "meritbadge0"
    t.string   "meritbadge1"
    t.string   "meritbadge2"
    t.string   "meritbadge3"
  end

  create_table "counselors", :force => true do |t|
    t.string   "name"
    t.string   "merit_badge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_associations", :force => true do |t|
    t.binary  "server_url"
    t.string  "handle"
    t.binary  "secret"
    t.integer "issued"
    t.integer "lifetime"
    t.string  "assoc_type"
  end

  create_table "open_id_nonces", :force => true do |t|
    t.string  "nonce"
    t.integer "created"
  end

  create_table "open_id_settings", :force => true do |t|
    t.string "setting"
    t.binary "value"
  end

  create_table "troops", :force => true do |t|
    t.string   "identity_url"
    t.string   "troopmaster"
    t.string   "troopmaster_address"
    t.string   "troopmaster_city"
    t.string   "troopmaster_zipcode"
    t.string   "troopmaster_email"
    t.integer  "number"
    t.string   "district"
    t.string   "council"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "session"
    t.string   "troopmaster_state"
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
    t.string   "open_id_url"
  end

end

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

ActiveRecord::Schema.define(:version => 7) do

  create_table "campers", :force => true do |t|
    t.string   "name"
    t.string   "rank"
    t.integer  "age"
    t.boolean  "nicoteh"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "troop_id"
    t.integer  "meritbadge1"
    t.integer  "meritbadge2"
    t.integer  "meritbadge3"
    t.integer  "meritbadge4"
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
  end

  create_table "users", :force => true do |t|
    t.string   "identity_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150312210753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string  "street_address"
    t.string  "city"
    t.string  "state"
    t.string  "zipcode"
    t.string  "zpid"
    t.integer "addressable_id"
    t.integer "addressable_type"
    t.integer "property_id"
    t.integer "contact_id"
  end

  add_index "addresses", ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "company"
    t.string   "telephone_number"
    t.string   "email"
    t.string   "url"
    t.text     "notes"
    t.string   "fax_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "reachable_id"
    t.string   "reachable_type"
  end

  add_index "contacts", ["reachable_id"], name: "index_contacts_on_reachable_id", using: :btree

  create_table "groundskeepers", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "property_id"
  end

  add_index "groundskeepers", ["property_id"], name: "index_groundskeepers_on_property_id", using: :btree
  add_index "groundskeepers", ["user_id"], name: "index_groundskeepers_on_user_id", using: :btree

  create_table "insurances", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "company"
    t.text     "description"
    t.integer  "policy_number"
    t.datetime "expiration_date"
    t.string   "url"
    t.text     "notes"
  end

  create_table "items", force: :cascade do |t|
    t.string   "category"
    t.string   "name"
    t.datetime "purchase_date"
    t.string   "serial_number"
    t.float    "price"
    t.string   "condition"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "room_id"
    t.integer  "property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.integer  "sqft"
    t.integer  "lotsize"
    t.integer  "total_rooms"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.string   "zpid"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "actual_rooms_count", default: 0
    t.integer  "yearbuilt"
    t.integer  "address_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.datetime "start_date"
    t.string   "name"
    t.string   "description"
    t.string   "frequency"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "sqft"
    t.string   "dimensions"
    t.string   "flooring_type"
    t.string   "wall_type"
    t.string   "paint_color"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "property_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "warranties", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "warranty_number"
    t.datetime "expiration_date"
    t.string   "url"
    t.text     "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end

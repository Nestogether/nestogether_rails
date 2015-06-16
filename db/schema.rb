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

ActiveRecord::Schema.define(version: 20150616135631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "addresses", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "apartment_id"
    t.string   "street"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "addresses", ["apartment_id"], name: "index_addresses_on_apartment_id", using: :btree
  add_index "addresses", ["district_id"], name: "index_addresses_on_district_id", using: :btree

  create_table "apartments", force: :cascade do |t|
    t.integer  "landlord_id"
    t.text     "description"
    t.integer  "public_room_amount"
    t.integer  "balcony_amount"
    t.boolean  "kitchen"
    t.integer  "type"
    t.string   "address_details"
    t.float    "area_size"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "apartments", ["landlord_id"], name: "index_apartments_on_landlord_id", using: :btree

  create_table "assets", force: :cascade do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.string   "file"
    t.string   "type"
    t.integer  "position"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "assets", ["viewable_id"], name: "index_assets_on_viewable_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "organizer_id"
    t.integer  "group_size"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.text     "description"
    t.string   "workflow_state"
  end

  add_index "groups", ["organizer_id"], name: "index_groups_on_organizer_id", using: :btree

  create_table "pins", force: :cascade do |t|
    t.integer "rent_case_id"
    t.integer "group_id"
  end

  add_index "pins", ["group_id"], name: "index_pins_on_group_id", using: :btree
  add_index "pins", ["rent_case_id"], name: "index_pins_on_rent_case_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "nickname"
    t.integer  "gender"
    t.datetime "birthdate"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "rent_cases", force: :cascade do |t|
    t.integer  "apartment_id"
    t.integer  "user_id"
    t.integer  "price"
    t.datetime "move_in_date"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "state"
  end

  add_index "rent_cases", ["apartment_id"], name: "index_rent_cases_on_apartment_id", using: :btree
  add_index "rent_cases", ["user_id"], name: "index_rent_cases_on_user_id", using: :btree

  create_table "share_cases", force: :cascade do |t|
    t.integer  "apartment_id"
    t.integer  "user_id"
    t.integer  "price"
    t.datetime "move_in_date"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "share_cases", ["apartment_id"], name: "index_share_cases_on_apartment_id", using: :btree
  add_index "share_cases", ["user_id"], name: "index_share_cases_on_user_id", using: :btree

  create_table "tenant_groups", force: :cascade do |t|
    t.string   "title"
    t.integer  "organizer_id"
    t.integer  "share_case_id"
    t.integer  "group_size"
    t.text     "description"
    t.string   "workflow_state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "tenant_groups", ["organizer_id"], name: "index_tenant_groups_on_organizer_id", using: :btree
  add_index "tenant_groups", ["share_case_id"], name: "index_tenant_groups_on_share_case_id", using: :btree

  create_table "user_group_ships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "groupable_id"
    t.string   "state",          default: "0"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "message"
    t.string   "groupable_type"
  end

  add_index "user_group_ships", ["groupable_id"], name: "index_user_group_ships_on_groupable_id", using: :btree
  add_index "user_group_ships", ["user_id"], name: "index_user_group_ships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110512183728) do

  create_table "horses", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "breeder_id"
    t.integer  "sire_id"
    t.integer  "dam_id"
    t.string   "bloodline"
    t.integer  "foal_year"
    t.string   "foal_country"
    t.string   "color"
    t.string   "breed"
    t.string   "gender"
    t.string   "markings"
    t.string   "vet_report_file_name"
    t.string   "xray_file_name"
    t.string   "dna_test_file_name"
    t.string   "registration_file_name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "horses", ["name"], :name => "index_horses_on_name"
  add_index "horses", ["user_id"], :name => "index_horses_on_user_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.string   "team"
    t.integer  "handicap"
    t.string   "best_result"
    t.integer  "age"
    t.string   "tel"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.boolean  "professional"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "cv_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["name"], :name => "index_players_on_name"
  add_index "players", ["user_id"], :name => "index_players_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.integer  "access",             :default => 0
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end

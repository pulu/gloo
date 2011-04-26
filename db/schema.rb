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

ActiveRecord::Schema.define(:version => 20110426190831) do

  create_table "horses", :force => true do |t|
    t.string   "name"
    t.integer  "breeder_id"
    t.integer  "sire_id"
    t.integer  "dam_id"
    t.string   "owner"
    t.integer  "foal_year"
    t.string   "foal_country"
    t.string   "color"
    t.string   "breed"
    t.boolean  "stallion"
    t.string   "vet_report_file_name"
    t.string   "xray_file_name"
    t.string   "dna_test_fname"
    t.string   "registration_file_name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

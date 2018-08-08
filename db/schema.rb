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

ActiveRecord::Schema.define(version: 2018_08_08_142350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enquiries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.integer "source", default: 10
    t.string "source_url"
    t.string "listing_make"
    t.string "listing_model"
    t.string "listing_year"
    t.string "listing_colour"
    t.string "listing_url"
    t.string "listing_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 10
  end

end

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

ActiveRecord::Schema.define(version: 20160925212201) do

  create_table "avatars", force: true do |t|
    t.integer  "user_id"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "avatars", ["user_id"], name: "index_avatars_on_user_id"

  create_table "industries", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_industries", force: true do |t|
    t.integer  "user_id"
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_industries", ["industry_id"], name: "index_user_industries_on_industry_id"
  add_index "user_industries", ["user_id"], name: "index_user_industries_on_user_id"

  create_table "users", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

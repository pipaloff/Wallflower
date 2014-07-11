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

ActiveRecord::Schema.define(version: 20140711054016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string  "name"
    t.string  "options",    default: [], array: true
    t.integer "project_id"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree
  add_index "categories", ["options"], name: "index_categories_on_options", using: :gin
  add_index "categories", ["project_id"], name: "index_categories_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string "name"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree

  create_table "texts", force: true do |t|
    t.text    "content"
    t.integer "category_id"
    t.integer "option_index"
  end

  add_index "texts", ["category_id"], name: "index_texts_on_category_id", using: :btree

end

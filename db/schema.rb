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

ActiveRecord::Schema.define(version: 20131002205046) do

  create_table "categories", force: true do |t|
    t.string   "category"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["category"], name: "index_categories_on_category"
  add_index "categories", ["image_id"], name: "index_categories_on_image_id"

  create_table "categories_images", id: false, force: true do |t|
    t.integer "image_id",    null: false
    t.integer "category_id", null: false
  end

  add_index "categories_images", ["category_id", "image_id"], name: "index_categories_images_on_category_id_and_image_id"
  add_index "categories_images", ["image_id", "category_id"], name: "index_categories_images_on_image_id_and_category_id"

  create_table "images", force: true do |t|
    t.string   "img_url"
    t.string   "img_name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tags"
  end

  add_index "images", ["tags"], name: "index_images_on_tags"
  add_index "images", ["user_id", "created_at"], name: "index_images_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end

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

ActiveRecord::Schema.define(version: 20160312155735) do

  create_table "guests", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.integer "reservation_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name"
    t.integer  "cost",                default: 1
    t.integer  "min_age",             default: 1
    t.integer  "min_nights",          default: 1
    t.integer  "max_guests",          default: 1
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "address"
    t.string   "phone_number"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "num_nights", default: 0
    t.integer  "num_guests", default: 0
    t.date     "check_in"
  end

  add_index "reservations", ["hotel_id"], name: "index_reservations_on_hotel_id"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "age",                    default: 0
    t.integer  "money",                  default: 0
    t.boolean  "admin",                  default: false
    t.string   "uid"
    t.string   "provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

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

ActiveRecord::Schema.define(version: 20160203122200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ssl_reminder_domains", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.string   "status"
    t.date     "expiration_date"
    t.boolean  "notification_enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "scanned",              default: false
  end

  add_index "ssl_reminder_domains", ["user_id"], name: "index_ssl_reminder_domains_on_user_id", using: :btree

end

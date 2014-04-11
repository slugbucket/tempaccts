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

ActiveRecord::Schema.define(version: 20140215071648) do

  create_table "account_group_tempaccts", force: true do |t|
    t.integer  "acct_group_id"
    t.integer  "tempacct_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_groups", force: true do |t|
    t.string   "name",           limit: 32, default: "Group name"
    t.text     "description"
    t.date     "default_expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_types", force: true do |t|
    t.string   "name",        limit: 64, null: false
    t.text     "description"
    t.date     "max_expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_logs", force: true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "act_action"
    t.string   "updated_by"
    t.text     "activity"
    t.datetime "act_tstamp"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "tempaccts", force: true do |t|
    t.string   "surname",     limit: 20,                      null: false
    t.string   "firstName",   limit: 20,                      null: false
    t.string   "uid",         limit: 32, default: "new_user", null: false
    t.integer  "account_type_id",       default: 1,           null: false
    t.string   "passwd",      limit: 16
    t.string   "owner",       limit: 32,                      null: false
    t.date     "expiry_date",                                 null: false
    t.boolean  "ftp_login",              default: false,      null: false
    t.integer  "in_ldap"
    t.boolean  "printing",               default: false,      null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",                        null: false
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end

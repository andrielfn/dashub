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

ActiveRecord::Schema.define(version: 20131020035626) do

  create_table "projects", force: true do |t|
    t.string   "name",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "approval_emoji",     default: "shipit", null: false
    t.integer  "required_approvals", default: 2,        null: false
    t.integer  "user_id"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "repositories", force: true do |t|
    t.string   "full_name",  null: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repositories", ["project_id", "full_name"], name: "index_repositories_on_project_id_and_full_name", unique: true, using: :btree
  add_index "repositories", ["project_id"], name: "index_repositories_on_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "provider_token"
    t.string   "provider_token_expires"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end

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

ActiveRecord::Schema.define(:version => 20100914041637) do

  create_table "commits", :force => true do |t|
    t.string   "gh_id"
    t.text     "message"
    t.datetime "timestamp"
    t.string   "url"
    t.text     "added"
    t.text     "removed"
    t.text     "modified"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gh_pushes", :force => true do |t|
    t.string   "before"
    t.string   "after"
    t.string   "ref"
    t.integer  "repository_id"
    t.text     "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gh_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "pledgie"
    t.text     "description"
    t.string   "homepage"
    t.integer  "watchers"
    t.integer  "forks"
    t.boolean  "private"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "hostname"
    t.string   "username"
    t.string   "password"
    t.string   "type"
    t.integer  "port"
    t.string   "default_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "domain"
    t.integer  "staging_server_id"
    t.integer  "production_server_id"
    t.string   "staging_path"
    t.string   "production_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gh_url"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

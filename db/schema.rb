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

ActiveRecord::Schema.define(version: 20150719145013) do

  create_table "campuses", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "courses", force: :cascade do |t|
    t.date     "started_on"
    t.date     "ended_on"
    t.integer  "campus_id"
    t.integer  "curriculum_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "curricula", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nickname"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "happens_on"
    t.text     "description"
    t.string   "website"
    t.integer  "campus_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "uploaded_file_file_name"
    t.string   "uploaded_file_content_type"
    t.integer  "uploaded_file_file_size"
    t.datetime "uploaded_file_updated_at"
    t.string   "website_html"
    t.string   "title"
    t.string   "location"
  end

  create_table "job_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "curriculum_id"
    t.string   "title"
    t.text     "description"
    t.string   "experience_desired"
    t.string   "website"
    t.date     "expires_on"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "active"
    t.string   "company_name"
    t.string   "location"
    t.string   "website_html"
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.date     "started_on"
    t.date     "ended_on"
    t.boolean  "current"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "company_name"
    t.string   "location"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "website"
    t.integer  "user_id"
    t.integer  "curriculum_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "website_html"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "current_city"
    t.string   "current_state"
    t.string   "github_profile"
    t.string   "website"
    t.string   "blog"
    t.integer  "course_id"
    t.boolean  "looking"
    t.boolean  "hiring"
    t.boolean  "is_cd"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "uploaded_file_file_name"
    t.string   "uploaded_file_content_type"
    t.integer  "uploaded_file_file_size"
    t.datetime "uploaded_file_updated_at"
    t.integer  "campus_id"
    t.integer  "curriculum_id"
    t.boolean  "is_instructor"
    t.boolean  "get_event_email"
    t.integer  "campus_notification_id"
    t.boolean  "get_job_email"
    t.boolean  "get_resource_email"
    t.boolean  "get_comment_email"
    t.string   "website_html"
    t.boolean  "is_mentor"
    t.string   "twitter"
    t.string   "slack_handle"
    t.string   "linked_in"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

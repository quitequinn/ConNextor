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

ActiveRecord::Schema.define(version: 20150328062501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "activity_type"
    t.integer  "source_id"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string  "notification_type"
    t.integer "actor_id"
    t.string  "message"
    t.string  "link"
    t.string  "verb"
    t.boolean "isRead"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "filled"
    t.string   "position_type"
    t.integer  "user_id"
  end

  add_index "positions", ["project_id"], name: "index_positions_on_project_id", using: :btree
  add_index "positions", ["user_id"], name: "index_positions_on_user_id", using: :btree

  create_table "project_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_post_id"
    t.string   "text"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "project_comments", ["project_post_id"], name: "index_project_comments_on_project_post_id", using: :btree
  add_index "project_comments", ["user_id"], name: "index_project_comments_on_user_id", using: :btree

  create_table "project_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_posts", ["project_id"], name: "index_project_posts_on_project_id", using: :btree
  add_index "project_posts", ["user_id"], name: "index_project_posts_on_user_id", using: :btree

  create_table "project_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "project_to_tags", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "project_tag_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "short_description"
    t.string   "long_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "request_type"
    t.integer  "request_type_id"
    t.string   "message"
    t.string   "link"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_project_follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_to_interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_to_interests", ["interest_id"], name: "index_user_to_interests_on_interest_id", using: :btree
  add_index "user_to_interests", ["user_id"], name: "index_user_to_interests_on_user_id", using: :btree

  create_table "user_to_project_tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_task_id"
    t.string   "relation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_to_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "project_user_class"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "user_to_skills", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_to_skills", ["skill_id"], name: "index_user_to_skills_on_skill_id", using: :btree
  add_index "user_to_skills", ["user_id"], name: "index_user_to_skills_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "name"
    t.string   "remember_token"
    t.string   "location"
    t.string   "image"
    t.string   "description"
    t.string   "phone"
    t.boolean  "confirmed"
    t.string   "confirm_code"
    t.string   "school"
    t.string   "school_email"
    t.string   "industry"
  end

  add_foreign_key "positions", "projects"
  add_foreign_key "positions", "users"
  add_foreign_key "project_comments", "project_posts"
  add_foreign_key "project_comments", "users"
  add_foreign_key "project_posts", "projects"
  add_foreign_key "project_posts", "users"
  add_foreign_key "user_to_interests", "interests"
  add_foreign_key "user_to_interests", "users"
  add_foreign_key "user_to_skills", "skills"
  add_foreign_key "user_to_skills", "users"
end

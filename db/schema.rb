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

ActiveRecord::Schema.define(version: 2020_09_30_084336) do

  create_table "camps", force: :cascade do |t|
    t.string "camp_period"
    t.string "camp_name"
  end

  create_table "comedy_stories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "camp_id"
    t.string "funny_comment_body"
    t.string "video_url"
    t.integer "good_count"
    t.integer "funny_count"
    t.integer "total_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "funnys", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comedy_story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "comedy_story_id"], name: "index_funnys_on_user_id_and_comedy_story_id", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comedy_story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "comedy_story_id"], name: "index_likes_on_user_id_and_comedy_story_id", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follow_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "follow_user_id"], name: "index_relationships_on_user_id_and_follow_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "mentor_name"
    t.string "account"
    t.string "discroption"
    t.string "password_digest"
    t.string "user_plofile_img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_name", "account"], name: "index_users_on_mentor_name_and_account", unique: true
  end

end

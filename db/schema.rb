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

ActiveRecord::Schema.define(version: 20150406151332) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "already_serifs", force: :cascade do |t|
    t.string   "word",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asumi_levels", force: :cascade do |t|
    t.integer  "patient_id",  limit: 4
    t.integer  "asumi_count", limit: 4
    t.integer  "tweet_count", limit: 4
    t.integer  "asumi_word",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asumi_tweets", force: :cascade do |t|
    t.integer  "patient_id", limit: 4
    t.string   "tweet",      limit: 255
    t.string   "tweet_id",   limit: 255
    t.datetime "tweet_time",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "link",       limit: 255
    t.boolean  "used",       limit: 1,   default: false
    t.datetime "post_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "last_data", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.string   "tweet_id",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_rankings", force: :cascade do |t|
    t.integer  "patient_id", limit: 4
    t.integer  "level",      limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "new_serifs", force: :cascade do |t|
    t.string   "word",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_fav_users", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "niconico_movie_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_movies", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.string   "description", limit: 255
    t.boolean  "priority",    limit: 1
    t.boolean  "disabled",    limit: 1,   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_populars", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.string   "description", limit: 255
    t.integer  "priority",    limit: 4
    t.boolean  "used",        limit: 1,   default: false, null: false
    t.boolean  "disabled",    limit: 1,   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_rt_users", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "niconico_movie_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: :cascade do |t|
    t.integer  "twitter_id",       limit: 8
    t.string   "name",             limit: 255
    t.string   "nickname",         limit: 255
    t.text     "description",      limit: 65535
    t.string   "icon",             limit: 255
    t.integer  "all_tweet",        limit: 4
    t.integer  "friend",           limit: 4
    t.integer  "follower",         limit: 4
    t.integer  "level",            limit: 4
    t.integer  "asumi_count",      limit: 4
    t.integer  "tweet_count",      limit: 4
    t.integer  "asumi_word",       limit: 4
    t.integer  "prev_level",       limit: 4
    t.integer  "prev_level_tweet", limit: 4
    t.integer  "prev_tweet_count", limit: 4
    t.integer  "prev_asumi_word",  limit: 4
    t.string   "since_id",         limit: 255
    t.boolean  "clear",            limit: 1,     default: false, null: false
    t.boolean  "protect",          limit: 1,     default: false, null: false
    t.boolean  "locked",           limit: 1,     default: false, null: false
    t.boolean  "disabled",         limit: 1,     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "popular_serifs", force: :cascade do |t|
    t.string   "word",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reply_serifs", force: :cascade do |t|
    t.string   "word",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "task",       limit: 255
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serifs", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.string   "word",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "today_niconicos", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.string   "description", limit: 255
    t.boolean  "priority",    limit: 1
    t.boolean  "used",        limit: 1,   default: false, null: false
    t.boolean  "disabled",    limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "today_youtubes", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.text     "description", limit: 65535
    t.integer  "priority",    limit: 4
    t.boolean  "used",        limit: 1,     default: false, null: false
    t.boolean  "disabled",    limit: 1,     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "twitter_id",  limit: 8
    t.string   "screen_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_fav_users", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "youtube_movie_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_movies", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.text     "description", limit: 65535
    t.integer  "priority",    limit: 4
    t.boolean  "disabled",    limit: 1,     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_populars", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.text     "description", limit: 65535
    t.integer  "priority",    limit: 4
    t.boolean  "used",        limit: 1,     default: false, null: false
    t.boolean  "disabled",    limit: 1,     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_rt_users", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "youtube_movie_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

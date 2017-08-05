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

ActiveRecord::Schema.define(version: 20170805041829) do

  create_table "admins", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "already_serifs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asumi_levels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "patient_id"
    t.integer "asumi_count"
    t.integer "tweet_count"
    t.integer "asumi_word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asumi_tweets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "patient_id"
    t.string "tweet"
    t.string "tweet_id"
    t.datetime "tweet_time", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["patient_id", "tweet_time"], name: "index_asumi_tweets_on_patient_id_and_tweet_time"
    t.index ["tweet_id"], name: "index_asumi_tweets_on_tweet_id", unique: true
  end

  create_table "blogs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "link"
    t.boolean "used", default: false
    t.datetime "post_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "last_data", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "category"
    t.string "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_rankings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "patient_id"
    t.integer "level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_serifs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_fav_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "user_id"
    t.integer "niconico_movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_movies", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.boolean "priority"
    t.boolean "disabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_populars", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.integer "priority"
    t.boolean "used", default: false, null: false
    t.boolean "disabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niconico_rt_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "user_id"
    t.integer "niconico_movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "twitter_id"
    t.string "name"
    t.string "nickname"
    t.text "description"
    t.string "icon"
    t.integer "all_tweet"
    t.integer "friend"
    t.integer "follower"
    t.integer "level"
    t.integer "asumi_count"
    t.integer "tweet_count"
    t.integer "asumi_word"
    t.integer "prev_level"
    t.integer "prev_level_tweet"
    t.integer "prev_tweet_count"
    t.integer "prev_asumi_word"
    t.string "since_id"
    t.boolean "clear", default: false, null: false
    t.boolean "protect", default: false, null: false
    t.boolean "locked", default: false, null: false
    t.boolean "disabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "popular_serifs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reply_serifs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "task"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serifs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "type"
    t.string "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "today_niconicos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.boolean "priority"
    t.boolean "used", default: false, null: false
    t.boolean "disabled", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "today_youtubes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.integer "priority"
    t.boolean "used", default: false, null: false
    t.boolean "disabled", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "twitter_id"
    t.string "screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_fav_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "user_id"
    t.integer "youtube_movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_movies", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.integer "priority"
    t.boolean "disabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_populars", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.integer "priority"
    t.boolean "used", default: false, null: false
    t.boolean "disabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "youtube_rt_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "user_id"
    t.integer "youtube_movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

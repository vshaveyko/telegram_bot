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

ActiveRecord::Schema.define(version: 20171204201753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "alquillar_features", force: :cascade do |t|
    t.string "type"
    t.string "geometry_type"
    t.float "geometry_lat"
    t.float "geometry_long"
    t.geometry "position", limit: {:srid=>0, :type=>"st_point"}
    t.string "geohash_prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alquillar_user_features", force: :cascade do |t|
    t.string "checked_pages", default: [], array: true
    t.boolean "has_next"
    t.integer "page_index", default: 0
    t.boolean "is_valid", default: true
    t.bigint "user_id"
    t.bigint "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_alquillar_user_features_on_feature_id"
    t.index ["user_id"], name: "index_alquillar_user_features_on_user_id"
  end

  create_table "alquillar_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "telegram_user_id"
    t.geometry "current_position", limit: {:srid=>0, :type=>"st_point"}
    t.geometry "last_position", limit: {:srid=>0, :type=>"st_point"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quest_comments", force: :cascade do |t|
    t.bigint "quest_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_comments_on_quest_id"
  end

  create_table "quest_location_views", force: :cascade do |t|
    t.bigint "quest_user_id"
    t.bigint "quest_location_id"
    t.boolean "is_valid", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_location_id"], name: "index_quest_location_views_on_quest_location_id"
    t.index ["quest_user_id"], name: "index_quest_location_views_on_quest_user_id"
  end

  create_table "quest_locations", force: :cascade do |t|
    t.float "lat"
    t.float "long"
    t.string "address"
    t.string "name"
    t.string "image_url"
    t.geography "position", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "phone_number"
    t.integer "feature_type", default: 0
    t.integer "quests_count", default: 0
    t.string "website_url"
    t.text "discounts"
  end

  create_table "quest_user_favourites", force: :cascade do |t|
    t.bigint "quest_user_id"
    t.bigint "quest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_user_favourites_on_quest_id"
    t.index ["quest_user_id"], name: "index_quest_user_favourites_on_quest_user_id"
  end

  create_table "quest_user_views", force: :cascade do |t|
    t.bigint "quest_user_id"
    t.string "viewable_type"
    t.bigint "viewable_id"
    t.boolean "is_valid", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_user_id"], name: "index_quest_user_views_on_quest_user_id"
    t.index ["viewable_type", "viewable_id"], name: "index_quest_user_views_on_viewable_type_and_viewable_id"
  end

  create_table "quest_user_visits", force: :cascade do |t|
    t.bigint "quest_user_id"
    t.bigint "quest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_user_visits_on_quest_id"
    t.index ["quest_user_id"], name: "index_quest_user_visits_on_quest_user_id"
  end

  create_table "quest_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "telegram_user_id"
    t.geography "current_position", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "latest_message_at"
    t.datetime "latest_location_updated_at", default: -> { "now()" }
  end

  create_table "quests", force: :cascade do |t|
    t.integer "ppl_min"
    t.integer "ppl_max"
    t.integer "cost_min"
    t.integer "cost_max"
    t.string "name"
    t.string "image_url"
    t.string "estimated_time"
    t.string "quest_games_quest_id"
    t.bigint "quest_location_id"
    t.text "description"
    t.string "video_url"
    t.integer "info_type", default: 0
    t.text "schedule_text"
    t.integer "comments_count", default: 0
    t.string "quest_url"
    t.index ["quest_location_id"], name: "index_quests_on_quest_location_id"
  end

  create_table "text_translation_translations", force: :cascade do |t|
    t.integer "text_translation_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "value"
    t.index ["locale"], name: "index_text_translation_translations_on_locale"
    t.index ["text_translation_id"], name: "index_text_translation_translations_on_text_translation_id"
  end

  create_table "text_translations", force: :cascade do |t|
    t.string "text_alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["text_alias"], name: "index_text_translations_on_text_alias", unique: true
  end

  add_foreign_key "alquillar_user_features", "alquillar_features", column: "feature_id"
  add_foreign_key "alquillar_user_features", "alquillar_users", column: "user_id"
  add_foreign_key "quest_comments", "quests"
  add_foreign_key "quest_location_views", "quest_locations"
  add_foreign_key "quest_location_views", "quest_users"
  add_foreign_key "quest_user_favourites", "quest_users"
  add_foreign_key "quest_user_favourites", "quests"
  add_foreign_key "quest_user_views", "quest_users"
  add_foreign_key "quest_user_visits", "quest_users"
  add_foreign_key "quest_user_visits", "quests"
end

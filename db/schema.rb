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

ActiveRecord::Schema.define(version: 20150413225241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doc_comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "doc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doc_comments", ["user_id", "doc_id", "created_at"], name: "index_doc_comments_on_user_id_and_doc_id_and_created_at", using: :btree

  create_table "doc_replies", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "doc_comment_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "doc_replies", ["user_id", "doc_comment_id", "created_at"], name: "index_doc_replies_on_user_id_and_doc_comment_id_and_created_at", using: :btree

  create_table "doc_votes", force: :cascade do |t|
    t.integer  "doc_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doc_votes", ["doc_id"], name: "index_doc_votes_on_doc_id", using: :btree
  add_index "doc_votes", ["user_id"], name: "index_doc_votes_on_user_id", using: :btree

  create_table "docs", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "topic"
    t.string   "license"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doc_comments_count", default: 0
    t.string   "filepicker_url"
  end

  add_index "docs", ["user_id"], name: "index_docs_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favoriteable_id"
    t.string   "favoriteable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "favorites", ["user_id", "favoriteable_id", "created_at"], name: "index_favorites_on_user_id_and_favoriteable_id_and_created_at", using: :btree

  create_table "message_texts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.text     "message"
    t.string   "type"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "rec_id"
    t.integer  "message_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "microposts", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end

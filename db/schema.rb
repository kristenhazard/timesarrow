# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091104200620) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amazon_index"
    t.string   "amazon_product_group"
  end

  create_table "item_statuses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "itemtype"
    t.string   "author"
    t.text     "description"
    t.string   "asin"
    t.string   "detailpageurl"
    t.string   "smallimageurl"
    t.string   "mediumimageurl"
    t.date     "publicationdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "isbn"
    t.string   "swatchimageurl"
    t.string   "largeimageurl"
    t.integer  "category_id"
  end

  create_table "rates", :force => true do |t|
    t.integer "score"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rate_id"
    t.integer  "rateable_id"
    t.string   "rateable_type", :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["rate_id"], :name => "index_ratings_on_rate_id"
  add_index "ratings", ["rateable_id", "rateable_type"], :name => "index_ratings_on_rateable_id_and_rateable_type"

  create_table "reviews", :force => true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "statuses", :force => true do |t|
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeline_items", :force => true do |t|
    t.integer  "timeline_id"
    t.integer  "item_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position_desc"
    t.integer  "position_type", :default => 1
  end

  add_index "timeline_items", ["item_id"], :name => "fk_item_id"
  add_index "timeline_items", ["timeline_id"], :name => "fk_timeline_id"

  create_table "timelines", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "imageurl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "subcategory"
    t.integer  "featured"
    t.string   "genre"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",        :default => 0,  :null => false
    t.integer  "failed_login_count", :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",   :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end

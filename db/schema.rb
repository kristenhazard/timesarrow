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

ActiveRecord::Schema.define(:version => 20090528201032) do

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "type"
    t.string   "author"
    t.string   "description"
    t.string   "asin"
    t.string   "detailpageurl"
    t.string   "smallimageurl"
    t.string   "mediumimageurl"
    t.date     "publicationdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

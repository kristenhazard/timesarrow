#create_table "timelines", :force => true do |t|
#  t.string   "name"
#  t.string   "description"
#  t.string   "imageurl"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.string   "category"
#  t.string   "subcategory"
#  t.integer  "featured"
#end

class Timeline < ActiveRecord::Base
  
  has_many :items, :through => :timeline_items
  has_many :timeline_items, :order => 'position DESC', :dependent => :destroy
  
  validates_presence_of :name, :category
  
  TIMELINE_CATEGORIES = [
    # Displayed   stored in db
    ["Books",     "Book"],
    ["Music",     "Music"],
    ["Movies",    "Movie"]
  ]
  
  TIMELINE_SUBCATEGORIES = [
    # Displayed   stored in db
    ["Awards",     "Awards"],
    ["Clubs",     "Clubs"],
    ["Series",    "Series"],
    ["Reviews",    "Reviews"]
  ]
  
  TIMELINE_FEATURED = [
    # Displayed   stored in db
    ["Yes",     "1"],
    ["No",     "0"]
  ]
  
end

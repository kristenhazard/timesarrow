#create_table "items", :force => true do |t|
#  t.string   "title"
#  t.string   "itemtype"
#  t.string   "author"
#  t.text     "description",     :limit => 2000
#  t.string   "asin"
#  t.string   "detailpageurl"
#  t.string   "smallimageurl"
#  t.string   "mediumimageurl"
#  t.date     "publicationdate"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#end

class Item < ActiveRecord::Base
  
  has_many :timelines, :through => :timeline_items
  has_many :timeline_items, :dependent => :destroy

  validates_presence_of :title, :asin, :detailpageurl, :author

end

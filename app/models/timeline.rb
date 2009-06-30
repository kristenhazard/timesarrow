class Timeline < ActiveRecord::Base
  has_many :timeline_items, :order => 'position DESC'
  has_many :items, :through => :timeline_items
  
  validates_presence_of :name, :category
  
  TIMELINE_CATEGORIES = [
    # Displayed   stored in db
    ["Books",     "books"],
    ["Music",     "music"],
    ["Movies",    "movies"]
  ]
  
end

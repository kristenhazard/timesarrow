class Timeline < ActiveRecord::Base
  
  has_many :items, :through => :timeline_items
  has_many :timeline_items, :order => 'position DESC', :dependent => :destroy
  
  validates_presence_of :name, :category
  
  TIMELINE_CATEGORIES = [
    # Displayed   stored in db
    ["Books",     "books"],
    ["Music",     "music"],
    ["Movies",    "movies"]
  ]
  
end

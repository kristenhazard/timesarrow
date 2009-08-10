#create_table "timelines", :force => true do |t|
#  t.string   "name"
#  t.string   "description"
#  t.string   "imageurl"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.string   "category"
#  t.string   "subcategory"
#  t.integer  "featured"
#  t.string   "genre"
#end

class Timeline < ActiveRecord::Base
  
  has_many :items, :through => :timeline_items
  has_many :timeline_items, :order => 'position DESC', :dependent => :destroy
  
  validates_presence_of :name, :category
  
  TIMELINE_CATEGORIES = [
    # Displayed   stored in db
    ["Books",     "Book"],
    ["Music",     "Music"],
    ["Movies",    "Movie"],
    ["Television", "Television"],
    ["Multimedia", "Multimedia"]
  ]
  
  TIMELINE_SUBCATEGORIES = [
    # Displayed   stored in db
    ["Awards",     "Awards"],
    ["Clubs",     "Clubs"],
    ["Reviews",    "Reviews"],
    ["Series",    "Series"]
  ]
  
  TIMELINE_FEATURED = [
    # Displayed   stored in db
    ["Yes",     "1"],
    ["No",     "0"]
  ]
  
  TIMELINE_GENRE_BOOKS = [
    # Displayed   stored in db
    ["Adventure",    "Adventure"],
    ["Autobiography",    "Autobiography"],
    ["Beyond Genre",    "Beyond Genre"],
    ["Biography",    "Biography"],
    ["Children",    "Children"],
    ["Cooking",    "Cooking"],
    ["Crime",    "Crime"],
    ["Criticism",    "Criticism"],
    ["Fiction",     "Fiction"],
    ["Graphic Novel",    "Graphic Novel"],
    ["History",    "History"],
    ["Horror",    "Horror"],
    ["Mixed",    "Mixed"],
    ["Mystery",    "Mystery"],
    ["Non Fiction",     "Non Fiction"],
    ["Poetry",    "Poetry"],
    ["Romance",    "Romance"],
    ["Science",    "Science"],
    ["Science Fiction",    "Science Fiction"],
    ["Sports",    "Sports"],
    ["Thriller",    "Thriller"],
    ["Western",    "Western"],
    ["Young People's Lit",    "Young People's Lit"]
  ]
  
end

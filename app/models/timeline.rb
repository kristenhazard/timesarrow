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
  
  has_many :items, :through => :timeline_items,  :order => 'title'
  has_many :timeline_items, :order => 'position ASC', :dependent => :destroy
  
  validates_presence_of :name, :category, :subcategory, :genre
  validates_numericality_of :featured, :on => :create, :message => "is not a number"
  
  def self.save_item_from_search(searchitem)
    # set item attributes based on response from amazon
    asin = searchitem.get("asin")
    @item = Item.find_by_asin(asin)
    if @item.nil?
      @item = Item.new
      @item.title = searchitem.get("title")
      @item.itemtype = searchitem.get("productgroup")
      @item.author = searchitem.get("author")
      if @item.author.nil?
        @item.author = searchitem.get("creator")
      end
      reviews = searchitem/'editorialreview'
      if (!reviews.nil?)
        review = reviews[0]
        Amazon::Element.get_hash(review) # [:source => ..., :content ==> ...]
        @item.description = Amazon::Element.get_unescaped(review, 'content')
      else
        @item.description = ""
      end
      @item.asin = asin
      @item.detailpageurl = searchitem.get("detailpageurl")
      @item.smallimageurl = searchitem.get("smallimage/url")
      @item.mediumimageurl = searchitem.get("mediumimage/url")
      @item.publicationdate = searchitem.get("publicationdate")
      @item.save!
    end
    @item
  end
  
  def self.save_timeline_item_from_search(item, timelineid)
    # save timeline_item
    @timeline_item = TimelineItem.new
    @timeline_item.item_id = @item.id
    @timeline_item.timeline_id = timelineid
    @timeline_item.position_desc = 'set'
    @timeline_item.save!
    @timeline_item.insert_at
  end
  
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

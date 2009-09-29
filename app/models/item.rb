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
  
  acts_as_rateable
  
  has_many :timelines, :through => :timeline_items
  has_many :timeline_items, :dependent => :destroy

  validates_presence_of :title, :asin, :detailpageurl
  validates_uniqueness_of :asin, :on => :create, :message => "must be unique"
  
  def self.save_item_from_search(searchitem)
    # set item attributes based on response from amazon
    asin = searchitem.get("asin")
    @item = find_by_asin(asin)
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

end

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
  has_many :item_statuses
  has_many :statuses, :through => :item_statuses
  has_many :reviews
  
  belongs_to :category

  validates_presence_of :title, :asin, :detailpageurl, :category_id
  validates_uniqueness_of :asin, :on => :create, :message => "must be unique"
  
  accepts_nested_attributes_for :reviews
  
  # used in collection_select
  def current_statusid
    current_user_session = UserSession.find
    if current_user_session
      is = self.item_statuses.find_by_user_id(current_user_session.user.id)
      if is
        statusid = is.status_id
      end
    end
  end
  
  def current_review
    current_user_session = UserSession.find
    review = self.reviews.find_by_user_id(current_user_session.user.id)
  end
  
  def self.save_item_from_search(asin)
    # set item attributes based on response from amazon
    item = find_or_create_by_asin(asin)
    searchitem = get_item_lookup(asin).items[0]
    unless searchitem.nil?
      item = set_item_attributes_from_search(searchitem, item)
      item.save!
    end
    item
  end
  
  def self.update_item_from_search(searchitem, item)
    item = set_item_attributes_from_search(searchitem, item)
    item.save!
  end
  
  def self.set_item_attributes_from_search(searchitem, item)
    item.title = searchitem.get("title")
    item.itemtype = searchitem.get("productgroup")
    item.author = searchitem.get("author")
    if item.author.nil?
      item.author = searchitem.get("creator")
    end
    reviews = searchitem/'editorialreview'
    if (!reviews.nil?)
      review = reviews[0]
      Amazon::Element.get_hash(review) # [:source => ..., :content ==> ...]
      review_content = Amazon::Element.get_unescaped(review, 'content')
    else
      review_content = ""
    end
    # strip out divs as they break my layout
    item.description = review_content.gsub(/<DIV>|<\/DIV>|&lt;DIV&gt;|&lt;\/DIV&gt;/i,'')
    item.asin = searchitem.get("asin")
    item.detailpageurl = searchitem.get("detailpageurl")
    item.smallimageurl = searchitem.get("smallimage/url")
    item.mediumimageurl = searchitem.get("mediumimage/url")
    item.largeimageurl = searchitem.get("largeimage/url")
    item.swatchimageurl = searchitem.get("swatchimage/url")
    item.publicationdate = searchitem.get("publicationdate")
    item.isbn = searchitem.get("isbn")
    pg = searchitem.get("productgroup")
    item.category_id = Category.find_by_amazon_product_group(pg).id
    item
  end
  
end

class Item < ActiveRecord::Base
  
  has_many :timelines, :through => :timeline_items
  has_many :timeline_items, :dependent => :destroy

  validates_presence_of :title, :asin, :detailpageurl, :author

end

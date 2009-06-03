class Item < ActiveRecord::Base

  has_many :timeline_items
  has_many :timelines, :through => :timeline_items

  validates_presence_of :title, :asin, :detailpageurl, :author

end

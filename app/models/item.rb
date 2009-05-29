class Item < ActiveRecord::Base

  validates_presence_of :title, :asin, :detailpageurl, :author

end

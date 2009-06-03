class TimelineItem < ActiveRecord::Base
  belongs_to :timeline
  belongs_to :item
  
  #validates_presence_of :title, :asin, :detailpageurl, :author
  
end

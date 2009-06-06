class TimelineItem < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :timeline
  belongs_to :item
  
  #validates_presence_of :title, :asin, :detailpageurl, :author
  
end

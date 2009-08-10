class TimelineItem < ActiveRecord::Base
  
  acts_as_list :scope => :timeline
  
  belongs_to :timeline
  belongs_to :item
  
  validates_presence_of :item_id, :timeline_id
  
end

# == Schema Information
# Schema version: 20091217200650
#
# Table name: timeline_items
#
#  id            :integer         not null, primary key
#  timeline_id   :integer
#  item_id       :integer
#  position      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  position_desc :string(255)
#  position_type :integer         default(1)
#

class TimelineItem < ActiveRecord::Base
  
  acts_as_list :scope => :timeline
  
  belongs_to :timeline
  belongs_to :item
  
  validates_presence_of :item_id, :timeline_id
  
  def self.save_timeline_item_from_search(item, timelineid)
    # save timeline_item
    @timeline_item = TimelineItem.new
    @timeline_item.item_id = item.id
    @timeline_item.timeline_id = timelineid
    @timeline_item.position_desc = 'set'
    @timeline_item.save!
    @timeline_item.insert_at
  end
  
end

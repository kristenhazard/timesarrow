# == Schema Information
# Schema version: 20091217200650
#
# Table name: item_statuses
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  item_id    :integer(4)
#  status_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class ItemStatus < ActiveRecord::Base
  attr_accessible :user_id, :item_id, :status_id
  
  belongs_to :item
  belongs_to :status
  belongs_to :user
  
  validates_presence_of :item_id, :status_id, :user_id
end

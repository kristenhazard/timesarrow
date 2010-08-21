# == Schema Information
# Schema version: 20100821203842
#
# Table name: item_statuses
#
#  id         :integer         primary key
#  user_id    :integer
#  item_id    :integer
#  status_id  :integer
#  created_at :timestamp
#  updated_at :timestamp
#

class ItemStatus < ActiveRecord::Base
  attr_accessible :user_id, :item_id, :status_id
  
  belongs_to :item
  belongs_to :status
  belongs_to :user
  
  validates_presence_of :item_id, :status_id, :user_id
end

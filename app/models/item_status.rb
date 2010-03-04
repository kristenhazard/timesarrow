# == Schema Information
# Schema version: 20100302232227
#
# Table name: item_statuses
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  item_id    :integer
#  status_id  :integer
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

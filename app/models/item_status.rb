class ItemStatus < ActiveRecord::Base
  attr_accessible :user_id, :item_id, :status_id
  
  belongs_to :item
  belongs_to :status
  belongs_to :user
  
  validates_presence_of :item_id, :status_id, :user_id
end

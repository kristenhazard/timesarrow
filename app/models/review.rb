# == Schema Information
# Schema version: 20100821203842
#
# Table name: reviews
#
#  id         :integer         primary key
#  item_id    :integer
#  user_id    :integer
#  content    :text
#  created_at :timestamp
#  updated_at :timestamp
#

class Review < ActiveRecord::Base
  attr_accessible :item_id, :user_id, :content
  
  belongs_to :user
  belongs_to :item
  
  def current_users_review?
    true
  end
end

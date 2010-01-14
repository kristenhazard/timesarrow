# == Schema Information
# Schema version: 20091217200650
#
# Table name: reviews
#
#  id         :integer(4)      not null, primary key
#  item_id    :integer(4)
#  user_id    :integer(4)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Review < ActiveRecord::Base
  attr_accessible :item_id, :user_id, :content
  
  belongs_to :user
  belongs_to :item
  
  def current_users_review?
    true
  end
end

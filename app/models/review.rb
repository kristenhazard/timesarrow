# == Schema Information
# Schema version: 20100302232227
#
# Table name: reviews
#
#  id         :integer         not null, primary key
#  item_id    :integer
#  user_id    :integer
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

class Review < ActiveRecord::Base
  attr_accessible :item_id, :user_id, :content
  
  belongs_to :user
  belongs_to :item
  
  def current_users_review?
    true
  end
end

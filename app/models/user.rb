class User < ActiveRecord::Base
  acts_as_authentic
  has_many :item_statuses
  has_many :statuses, :through => :item_statuses
  has_many :reviews
end

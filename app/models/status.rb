class Status < ActiveRecord::Base
  attr_accessible :description, :category_id
  belongs_to :category
  has_many :item_statuses
end

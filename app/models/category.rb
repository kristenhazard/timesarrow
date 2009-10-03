class Category < ActiveRecord::Base
  attr_accessible :name, :amazon_index, :amazon_product_group
  has_many :items
end

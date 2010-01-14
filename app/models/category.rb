# == Schema Information
# Schema version: 20091217200650
#
# Table name: categories
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  amazon_index         :string(255)
#  amazon_product_group :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name, :amazon_index, :amazon_product_group
  has_many :items
  has_many :statuses
end

# == Schema Information
# Schema version: 20100821203842
#
# Table name: categories
#
#  id                   :integer         primary key
#  name                 :string(255)
#  created_at           :timestamp
#  updated_at           :timestamp
#  amazon_index         :string(255)
#  amazon_product_group :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name, :amazon_index, :amazon_product_group
  has_many :items
  has_many :statuses
end

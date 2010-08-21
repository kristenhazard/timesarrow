# == Schema Information
# Schema version: 20100821203842
#
# Table name: statuses
#
#  id          :integer         primary key
#  description :string(255)
#  category_id :integer
#  created_at  :timestamp
#  updated_at  :timestamp
#

class Status < ActiveRecord::Base
  attr_accessible :description, :category_id
  belongs_to :category
  has_many :item_statuses
end

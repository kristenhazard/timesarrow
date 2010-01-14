# == Schema Information
# Schema version: 20091217200650
#
# Table name: statuses
#
#  id          :integer(4)      not null, primary key
#  description :string(255)
#  category_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Status < ActiveRecord::Base
  attr_accessible :description, :category_id
  belongs_to :category
  has_many :item_statuses
end

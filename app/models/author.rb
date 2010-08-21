# == Schema Information
# Schema version: 20100821203842
#
# Table name: authors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
  has_many :items, :through => :item_authors
  has_many :item_authors
  validates_presence_of :name
end

# == Schema Information
# Schema version: 20100821203842
#
# Table name: item_authors
#
#  id         :integer         not null, primary key
#  item_id    :integer
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class ItemAuthor < ActiveRecord::Base
  belongs_to :author
  belongs_to :item
end

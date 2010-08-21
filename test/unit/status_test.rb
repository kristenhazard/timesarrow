require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  
  should belong_to :category
  should have_many :item_statuses
  
end

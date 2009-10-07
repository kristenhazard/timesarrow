require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  
  should_belong_to :category
  should_have_many :item_statuses
  
end

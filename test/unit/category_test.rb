require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  should have_many :items
  should have_many :statuses
  
  
end

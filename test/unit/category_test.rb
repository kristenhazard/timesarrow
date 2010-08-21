require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should "be valid" do
    assert Category.new.valid?
  end
  
  should have_many :items
  should have_many :statuses
end

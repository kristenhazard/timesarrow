require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should "be valid" do
    assert Category.new.valid?
  end
  
  should_have_many :items
end

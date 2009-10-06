require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  should "be valid" do
    assert Category.new.valid?
  end
  
  should_belong_to :category
  should_have_many :item_statuses
  
end

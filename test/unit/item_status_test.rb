require 'test_helper'

class ItemStatusTest < ActiveSupport::TestCase
  should "be valid" do
    assert ItemStatus.new.invalid?
  end
  
  should_belong_to :item, :status, :user
  
  should_validate_presence_of :status_id, :user_id, :item_id
  
end

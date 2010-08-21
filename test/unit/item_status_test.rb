require 'test_helper'

class ItemStatusTest < ActiveSupport::TestCase
  
  should belong_to :item
  should belong_to :status
  should belong_to :user
  
  should validate_presence_of :status_id
  should validate_presence_of :item_id
  should validate_presence_of :user_id
end

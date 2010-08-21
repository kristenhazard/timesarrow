require 'test_helper'

class ItemAuthorTest < ActiveSupport::TestCase
  
  should belong_to(:author)
  should belong_to(:item)
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

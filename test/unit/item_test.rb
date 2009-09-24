require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  def test_should_save_item_with_required_fields
    item = Item.new(:title => 'Test Title',
                    :asin => 'ASIN3',
                    :detailpageurl => 'http://amazon.com')
    assert item.save, "Item saved with required fields"
  end
  
  def test_should_not_save_item_without_required_fields
    item = Item.new()
    assert !item.save, "Item saved with required fields"
    assert item.errors.invalid?(:title)
    assert item.errors.invalid?(:asin)
    assert item.errors.invalid?(:detailpageurl)
  end
  
  test "duplicate asin" do
    item = Item.new(:title => 'Test Title',
                    :asin => 'ASIN',
                    :detailpageurl => 'http://amazon.com')
    assert !item.valid?
    assert item.errors.invalid?(:asin)
  end
end

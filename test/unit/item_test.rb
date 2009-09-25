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
  
  test "duplicate asin should not be valid" do
    item = Item.new(:title => 'March',
                    :asin => '0143036661',
                    :detailpageurl => 'http://amazon.com')
    assert !item.save, "Item should not save with duplicate ASIN"
    assert !item.valid?, "Item should not be valid with duplicate ASIN"
    assert item.errors.invalid?(:asin), "Item invalid error should be due to ASIN"
  end
  
  should_have_many :timelines, :through => :timeline_items
  
  should_validate_presence_of :title, :asin, :detailpageurl
  
  should_validate_uniqueness_of :asin, :message => "must be unique"
  

end

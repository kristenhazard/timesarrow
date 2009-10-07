require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  
  setup :activate_authlogic

  should_have_many :timeline_items
  should_have_many :timelines, :through => :timeline_items
  should_have_many :item_statuses
  should_have_many :statuses, :through => :item_statuses
  

  should_validate_presence_of :title, :asin, :detailpageurl,:category_id

  should_validate_uniqueness_of :asin, :message => "must be unique"
  
  should_belong_to :category

  def test_should_save_item_with_required_fields
    item = Item.new(:title => 'Test Title',
                    :asin => 'ASIN3',
                    :detailpageurl => 'http://amazon.com',
                    :category_id => categories(:book))
    assert item.save, "Item saved with required fields"
  end
  
  def test_should_not_save_item_without_required_fields
    item = Item.new()
    assert !item.save, "Item saved with required fields"
    assert item.errors.invalid?(:title)
    assert item.errors.invalid?(:asin)
    assert item.errors.invalid?(:detailpageurl)
    assert item.errors.invalid?(:category_id)
  end
  
  test "duplicate asin should not be valid" do
    item = Item.new(:title => items(:book_march).title,
                    :asin => items(:book_march).asin,
                    :detailpageurl => 'http://amazon.com',
                    :category_id => categories(:book))
    assert !item.save, "Item should not save with duplicate ASIN"
    assert !item.valid?, "Item should not be valid with duplicate ASIN"
    assert item.errors.invalid?(:asin), "Item invalid error should be due to ASIN"
  end
  
  def test_should_not_create_duplicate_asin_in_save_item_from_search
    item = Item.new(:title => items(:book_march).title,
                    :asin => items(:book_march).asin,
                    :detailpageurl => 'http://www.amazon.com/Brief-Wondrous-Life-Oscar-Wao/dp/1594483299%3FSubscriptionId%3D1FZFQX4TKGCZNDQ44P02%26tag%3Dtimesarrow-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D1594483299',
                    :category_id => categories(:book)
                   )
    item2 = Item.save_item_from_search(item.asin)
    assert item2.id.eql? items(:book_march).id
    
  end
  
  def test_should_create_new_item_from_search
    assert_difference('Item.count') do
      item = Item.save_item_from_search('0312427735')
    end
  end
  
  def test_should_set_item_attributes_from_search
    searchitem = get_item_lookup(items(:book_march).asin).items[0]
    item = Item.new
    Item.set_item_attributes_from_search(searchitem,item)
    assert item.title.eql? 'March'
    assert item.author.eql? 'Geraldine Brooks'
  end
  
  def test_should_set_item_attributes_from_search_and_save
    
  end
  
  def test_get_current_statusid
    UserSession.create(users(:admin))
    item = items(:book_march)
    #debugger
    assert item.current_statusid.eql? statuses(:read).id
  end


end

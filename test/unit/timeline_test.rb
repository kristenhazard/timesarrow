require File.dirname(__FILE__) + '/../test_helper'

class TimelineTest < ActiveSupport::TestCase
  
  setup :activate_authlogic
  
  should have_many :items
  should have_many :timeline_items
  
  def test_should_save_timeline_with_main_fields
    timeline = Timeline.new(
                              :name => 'Pulitzer Prize Winners',
                              :category => 'Book',
                              :subcategory => 'Awards',
                              :featured => 0,
                              :genre => 'Adventure'
                           )
    assert timeline.save, "Saved with all required fields"
    assert Timeline.filtered_genre('Adventure').count.eql? 1
  end
  
  def test_should_not_save_timeline_without_name
    timeline = Timeline.new(
                              :category => 'Book',
                              :subcategory => 'Awards',
                              :featured => 0,
                              :genre => 'Adventure'
                           )
    assert !timeline.save, "Saved timeline without name"
  end
  
  def test_should_not_save_timeline_without_category
    timeline = Timeline.new(
                              :name => 'Pulitzer Prize Winners',
                              :subcategory => 'Awards',
                              :featured => 0,
                              :genre => 'Adventure'
                           )
    assert !timeline.save, "Saved timeline without category"
  end
  
  def test_should_not_save_timeline_without_subcategory
    timeline = Timeline.new(
                              :name => 'Pulitzer Prize Winners',
                              :category => 'Book',
                              :featured => 0,
                              :genre => 'Adventure'
                           )
    assert !timeline.save, "Saved timeline without subcategory"
  end
  
  def test_should_not_save_timeline_without_genre
    timeline = Timeline.new(
                              :name => 'Pulitzer Prize Winners',
                              :category => 'Book',
                              :subcategory => 'Awards',
                              :featured => 0
                           )
    assert !timeline.save, "Saved timeline without genre"
  end
  
  test "featured must be 0 or 1" do
    timeline = Timeline.new(
                              :name => 'Pulitzer Prize Winners',
                              :category => 'Book',
                              :subcategory => 'Awards',
                              :featured => 'Yes'
                           )
    assert !timeline.valid?
    assert timeline.errors.invalid?(:featured)
  end
  
  def test_should_return_featured_with_named_scope
    @timelines = Timeline.featured
    assert @timelines.count.eql? 1
  end
  
  def test_should_return_filtered_with_name_scope
    @timelines = Timeline.filtered_cat('Book')
    assert @timelines.count.eql? 2
    @timelines = Timeline.filtered_cat('Book').filtered_subcat('Awards')
    assert @timelines.count.eql? 2
    @timelines = Timeline.filtered_cat('Book').filtered_subcat('Awards').filtered_genre('Fiction')
    assert @timelines.count.eql? 1
  end
  
  def test_search_timeline_with_timeline_name
    @timelines = Timeline.search('Featured', nil)
    assert @timelines.count.eql? 2
  end
  
  def test_current_user_is_owner
    UserSession.create(users(:user))
    timeline = timelines(:awards_fiction_featured)
    assert timeline.current_user_is_owner? 
  end
  
  # def test_search_timeline_with_item_name
  #   @timelines = Timeline.search('March', nil)
  #   assert @timelines.count.eql? 1
  #   assert @timelines.first.name.eql? 'Fiction Featured'
  # end
  # 
  # def test_search_timeline_with_item_author
  #   @timelines = Timeline.search('Brooks', nil)
  #   assert @timelines.count.eql? 1
  #   assert @timelines.first.name.eql? 'Fiction Featured'
  # end
  

end

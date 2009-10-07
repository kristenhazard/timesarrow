require File.dirname(__FILE__) + '/../test_helper'

class TimelineTest < ActiveSupport::TestCase
  
  should_have_many :items, :through => :timeline_items
  should_have_many :timeline_items
  
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
  

end

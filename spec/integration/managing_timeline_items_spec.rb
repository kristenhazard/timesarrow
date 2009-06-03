require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing TimelineItems" do
  before(:each) do
    @valid_attributes = {
      :timeline_id => 1,
      :item_id => 1,
      :position => 1
    }
  end

  describe "viewing index" do
    it "lists all TimelineItems" do
      timeline_item = TimelineItem.create!(@valid_attributes)
      visit timeline_items_path
      response.should have_selector("a", :href => timeline_item_path(timeline_item))
    end
  end
end

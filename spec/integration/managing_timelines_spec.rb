require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Timelines" do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :imageurl => "value for imageurl"
    }
  end

  describe "viewing index" do
    it "lists all Timelines" do
      timeline = Timeline.create!(@valid_attributes)
      visit timelines_path
      response.should have_selector("a", :href => timeline_path(timeline))
    end
  end
end

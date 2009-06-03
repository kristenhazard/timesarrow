require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimelineItem do
  before(:each) do
    @valid_attributes = {
      :timeline_id => 1,
      :item_id => 1,
      :position => 1
    }
  end

  it "should create a new instance given valid attributes" do
    TimelineItem.create!(@valid_attributes)
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timeline do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :imageurl => "value for imageurl"
    }
  end

  it "should create a new instance given valid attributes" do
    Timeline.create!(@valid_attributes)
  end
end

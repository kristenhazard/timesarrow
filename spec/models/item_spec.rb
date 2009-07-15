require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Item do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :itemtype => "value for type",
      :author => "value for author",
      :description => "value for description",
      :asin => "value for asin",
      :detailpageurl => "value for detailpageurl",
      :smallimageurl => "value for smallimageurl",
      :mediumimageurl => "value for mediumimageurl",
      :publicationdate => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Item.create!(@valid_attributes)
  end
end

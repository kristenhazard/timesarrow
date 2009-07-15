require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/index.html.erb" do
  include ItemsHelper
  
  before(:each) do
    assigns[:items] = [
      stub_model(Item,
        :title => "value for title",
        :itemtype => "book",
        :author => "value for author",
        :description => "value for description",
        :asin => "value for asin",
        :detailpageurl => "value for detailpageurl",
        :smallimageurl => "value for smallimageurl",
        :mediumimageurl => "value for mediumimageurl"
      ),
      stub_model(Item,
        :title => "value for title",
        :itemtype => "music",
        :author => "value for author",
        :description => "value for description",
        :asin => "value for asin",
        :detailpageurl => "value for detailpageurl",
        :smallimageurl => "value for smallimageurl",
        :mediumimageurl => "value for mediumimageurl"
      )
    ]
  end

  it "renders a list of items" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    #response.should have_tag("tr>td", "value for itemtype".to_s, 2)
    response.should have_tag("tr>td", "value for author".to_s, 2)
    #response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for asin".to_s, 2)
    response.should have_tag("tr>td", "value for detailpageurl".to_s, 2)
    response.should have_tag("tr>td", "value for smallimageurl".to_s, 2)
    response.should have_tag("tr>td", "value for mediumimageurl".to_s, 2)
  end
end


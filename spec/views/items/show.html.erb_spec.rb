require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/show.html.erb" do
  include ItemsHelper
  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :title => "value for title",
      :type => "value for type",
      :author => "value for author",
      :description => "value for description",
      :asin => "value for asin",
      :detailpageurl => "value for detailpageurl",
      :smallimageurl => "value for smallimageurl",
      :mediumimageurl => "value for mediumimageurl"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ type/)
    response.should have_text(/value\ for\ author/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ asin/)
    response.should have_text(/value\ for\ detailpageurl/)
    response.should have_text(/value\ for\ smallimageurl/)
    response.should have_text(/value\ for\ mediumimageurl/)
  end
end


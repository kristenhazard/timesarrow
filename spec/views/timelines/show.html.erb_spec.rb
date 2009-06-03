require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timelines/show.html.erb" do
  include TimelinesHelper
  before(:each) do
    assigns[:timeline] = @timeline = stub_model(Timeline,
      :name => "value for name",
      :description => "value for description",
      :imageurl => "value for imageurl"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ imageurl/)
  end
end

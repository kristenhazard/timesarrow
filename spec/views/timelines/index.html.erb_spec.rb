require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timelines/index.html.erb" do
  include TimelinesHelper

  before(:each) do
    assigns[:timelines] = [
      stub_model(Timeline,
        :name => "value for name",
        :description => "value for description",
        :imageurl => "value for imageurl"
      ),
      stub_model(Timeline,
        :name => "value for name",
        :description => "value for description",
        :imageurl => "value for imageurl"
      )
    ]
  end

  it "renders a list of timelines" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for imageurl".to_s, 2)
  end
end

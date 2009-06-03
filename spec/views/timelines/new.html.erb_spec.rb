require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timelines/new.html.erb" do
  include TimelinesHelper

  before(:each) do
    assigns[:timeline] = stub_model(Timeline,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :imageurl => "value for imageurl"
    )
  end

  it "renders new timeline form" do
    render

    response.should have_tag("form[action=?][method=post]", timelines_path) do
      with_tag("input#timeline_name[name=?]", "timeline[name]")
      with_tag("input#timeline_description[name=?]", "timeline[description]")
      with_tag("input#timeline_imageurl[name=?]", "timeline[imageurl]")
    end
  end
end

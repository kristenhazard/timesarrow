require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timelines/edit.html.erb" do
  include TimelinesHelper

  before(:each) do
    assigns[:timeline] = @timeline = stub_model(Timeline,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description",
      :imageurl => "value for imageurl"
    )
  end

  it "renders the edit timeline form" do
    render

    response.should have_tag("form[action=#{timeline_path(@timeline)}][method=post]") do
      with_tag('input#timeline_name[name=?]', "timeline[name]")
      with_tag('input#timeline_description[name=?]', "timeline[description]")
      with_tag('input#timeline_imageurl[name=?]', "timeline[imageurl]")
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timeline_items/index.html.erb" do
  include TimelineItemsHelper

  before(:each) do
    assigns[:timeline_items] = [
      stub_model(TimelineItem,
        :timeline_id => 1,
        :item_id => 1,
        :position => 1
      ),
      stub_model(TimelineItem,
        :timeline_id => 1,
        :item_id => 2,
        :position => 2
      )
    ]
  end

  it "renders a list of timeline_items" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end

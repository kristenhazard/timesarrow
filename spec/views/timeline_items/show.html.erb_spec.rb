require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timeline_items/show.html.erb" do
  include TimelineItemsHelper
  before(:each) do
    assigns[:timeline_item] = @timeline_item = stub_model(TimelineItem,
      :timeline_id => 1,
      :item_id => 1,
      :position => 1,
      :position_desc => '1'
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timeline_items/new.html.erb" do
  include TimelineItemsHelper

  before(:each) do
    assigns[:timeline_item] = stub_model(TimelineItem,
      :new_record? => true,
      :timeline_id => 1,
      :item_id => 1,
      :position => 1
    )
  end

  it "renders new timeline_item form" do
    render

    response.should have_tag("form[action=?][method=post]", timeline_items_path) do
      with_tag("input#timeline_item_timeline_id[name=?]", "timeline_item[timeline_id]")
      with_tag("input#timeline_item_item_id[name=?]", "timeline_item[item_id]")
      with_tag("input#timeline_item_position[name=?]", "timeline_item[position]")
    end
  end
end

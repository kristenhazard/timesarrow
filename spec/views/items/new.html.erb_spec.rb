require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/new.html.erb" do
  include ItemsHelper
  
  before(:each) do
    assigns[:item] = stub_model(Item,
      :new_record? => true,
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

  it "renders new item form" do
    render
    
    response.should have_tag("form[action=?][method=post]", items_path) do
      with_tag("input#item_title[name=?]", "item[title]")
      with_tag("input#item_type[name=?]", "item[type]")
      with_tag("input#item_author[name=?]", "item[author]")
      with_tag("input#item_description[name=?]", "item[description]")
      with_tag("input#item_asin[name=?]", "item[asin]")
      with_tag("input#item_detailpageurl[name=?]", "item[detailpageurl]")
      with_tag("input#item_smallimageurl[name=?]", "item[smallimageurl]")
      with_tag("input#item_mediumimageurl[name=?]", "item[mediumimageurl]")
    end
  end
end



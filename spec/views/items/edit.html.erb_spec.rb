require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/items/edit.html.erb" do
  include ItemsHelper
  
  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :new_record? => false,
      :title => "value for title",
      :itemtype => "value for type",
      :author => "value for author",
      :description => "value for description",
      :asin => "value for asin",
      :detailpageurl => "value for detailpageurl",
      :smallimageurl => "value for smallimageurl",
      :mediumimageurl => "value for mediumimageurl"
    )
  end

  it "renders the edit item form" do
    render
    
    response.should have_tag("form[action=#{item_path(@item)}][method=post]") do
      with_tag('input#item_title[name=?]', "item[title]")
      with_tag('input#item_itemtype[name=?]', "item[itemtype]")
      with_tag('input#item_author[name=?]', "item[author]")
      with_tag('textarea#item_description[name=?]', "item[description]")
      with_tag('input#item_asin[name=?]', "item[asin]")
      with_tag('input#item_detailpageurl[name=?]', "item[detailpageurl]")
      with_tag('input#item_smallimageurl[name=?]', "item[smallimageurl]")
      with_tag('input#item_mediumimageurl[name=?]', "item[mediumimageurl]")
    end
  end
end



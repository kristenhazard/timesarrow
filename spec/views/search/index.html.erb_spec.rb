require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/search/index" do
  before(:each) do
    render 'search/index'
  end
  
  it "should have a form, keywords input and submit button" do
    response.should have_selector("form") do |form|
      form.should have_selector("input[type=text][name=keywords]")
      form.should have_selector("input[type=submit]") 
    end
  end
  
end

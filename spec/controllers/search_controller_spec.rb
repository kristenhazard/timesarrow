require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do

  #Delete these examples and add some real ones
  it "should use SearchController" do
    controller.should be_an_instance_of(SearchController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end

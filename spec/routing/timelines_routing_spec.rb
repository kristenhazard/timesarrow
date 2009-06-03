require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimelinesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "timelines", :action => "index").should == "/timelines"
    end

    it "maps #new" do
      route_for(:controller => "timelines", :action => "new").should == "/timelines/new"
    end

    it "maps #show" do
      route_for(:controller => "timelines", :action => "show", :id => "1").should == "/timelines/1"
    end

    it "maps #edit" do
      route_for(:controller => "timelines", :action => "edit", :id => "1").should == "/timelines/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "timelines", :action => "create").should == {:path => "/timelines", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "timelines", :action => "update", :id => "1").should == {:path =>"/timelines/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "timelines", :action => "destroy", :id => "1").should == {:path =>"/timelines/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/timelines").should == {:controller => "timelines", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/timelines/new").should == {:controller => "timelines", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/timelines").should == {:controller => "timelines", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/timelines/1").should == {:controller => "timelines", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/timelines/1/edit").should == {:controller => "timelines", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/timelines/1").should == {:controller => "timelines", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/timelines/1").should == {:controller => "timelines", :action => "destroy", :id => "1"}
    end
  end
end

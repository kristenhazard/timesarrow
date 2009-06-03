require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimelinesController do

  def mock_timeline(stubs={})
    @mock_timeline ||= mock_model(Timeline, stubs)
  end

  describe "GET index" do
    it "assigns all timelines as @timelines" do
      Timeline.stub!(:find).with(:all).and_return([mock_timeline])
      get :index
      assigns[:timelines].should == [mock_timeline]
    end
  end

  describe "GET show" do
    it "assigns the requested timeline as @timeline" do
      Timeline.stub!(:find).with("37").and_return(mock_timeline)
      get :show, :id => "37"
      assigns[:timeline].should equal(mock_timeline)
    end
  end

  describe "GET new" do
    it "assigns a new timeline as @timeline" do
      Timeline.stub!(:new).and_return(mock_timeline)
      get :new
      assigns[:timeline].should equal(mock_timeline)
    end
  end

  describe "GET edit" do
    it "assigns the requested timeline as @timeline" do
      Timeline.stub!(:find).with("37").and_return(mock_timeline)
      get :edit, :id => "37"
      assigns[:timeline].should equal(mock_timeline)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created timeline as @timeline" do
        Timeline.stub!(:new).with({'these' => 'params'}).and_return(mock_timeline(:save => true))
        post :create, :timeline => {:these => 'params'}
        assigns[:timeline].should equal(mock_timeline)
      end

      it "redirects to the created timeline" do
        Timeline.stub!(:new).and_return(mock_timeline(:save => true))
        post :create, :timeline => {}
        response.should redirect_to(timeline_url(mock_timeline))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved timeline as @timeline" do
        Timeline.stub!(:new).with({'these' => 'params'}).and_return(mock_timeline(:save => false))
        post :create, :timeline => {:these => 'params'}
        assigns[:timeline].should equal(mock_timeline)
      end

      it "re-renders the 'new' template" do
        Timeline.stub!(:new).and_return(mock_timeline(:save => false))
        post :create, :timeline => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested timeline" do
        Timeline.should_receive(:find).with("37").and_return(mock_timeline)
        mock_timeline.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :timeline => {:these => 'params'}
      end

      it "assigns the requested timeline as @timeline" do
        Timeline.stub!(:find).and_return(mock_timeline(:update_attributes => true))
        put :update, :id => "1"
        assigns[:timeline].should equal(mock_timeline)
      end

      it "redirects to the timeline" do
        Timeline.stub!(:find).and_return(mock_timeline(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(timeline_url(mock_timeline))
      end
    end

    describe "with invalid params" do
      it "updates the requested timeline" do
        Timeline.should_receive(:find).with("37").and_return(mock_timeline)
        mock_timeline.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :timeline => {:these => 'params'}
      end

      it "assigns the timeline as @timeline" do
        Timeline.stub!(:find).and_return(mock_timeline(:update_attributes => false))
        put :update, :id => "1"
        assigns[:timeline].should equal(mock_timeline)
      end

      it "re-renders the 'edit' template" do
        Timeline.stub!(:find).and_return(mock_timeline(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested timeline" do
      Timeline.should_receive(:find).with("37").and_return(mock_timeline)
      mock_timeline.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the timelines list" do
      Timeline.stub!(:find).and_return(mock_timeline(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(timelines_url)
    end
  end

end

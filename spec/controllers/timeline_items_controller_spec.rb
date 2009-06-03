require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimelineItemsController do

  def mock_timeline_item(stubs={})
    @mock_timeline_item ||= mock_model(TimelineItem, stubs)
  end

  describe "GET index" do
    it "assigns all timeline_items as @timeline_items" do
      TimelineItem.stub!(:find).with(:all).and_return([mock_timeline_item])
      get :index
      assigns[:timeline_items].should == [mock_timeline_item]
    end
  end

  describe "GET show" do
    it "assigns the requested timeline_item as @timeline_item" do
      TimelineItem.stub!(:find).with("37").and_return(mock_timeline_item)
      get :show, :id => "37"
      assigns[:timeline_item].should equal(mock_timeline_item)
    end
  end

  describe "GET new" do
    it "assigns a new timeline_item as @timeline_item" do
      TimelineItem.stub!(:new).and_return(mock_timeline_item)
      get :new
      assigns[:timeline_item].should equal(mock_timeline_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested timeline_item as @timeline_item" do
      TimelineItem.stub!(:find).with("37").and_return(mock_timeline_item)
      get :edit, :id => "37"
      assigns[:timeline_item].should equal(mock_timeline_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created timeline_item as @timeline_item" do
        TimelineItem.stub!(:new).with({'these' => 'params'}).and_return(mock_timeline_item(:save => true))
        post :create, :timeline_item => {:these => 'params'}
        assigns[:timeline_item].should equal(mock_timeline_item)
      end

      it "redirects to the created timeline_item" do
        TimelineItem.stub!(:new).and_return(mock_timeline_item(:save => true))
        post :create, :timeline_item => {}
        response.should redirect_to(timeline_item_url(mock_timeline_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved timeline_item as @timeline_item" do
        TimelineItem.stub!(:new).with({'these' => 'params'}).and_return(mock_timeline_item(:save => false))
        post :create, :timeline_item => {:these => 'params'}
        assigns[:timeline_item].should equal(mock_timeline_item)
      end

      it "re-renders the 'new' template" do
        TimelineItem.stub!(:new).and_return(mock_timeline_item(:save => false))
        post :create, :timeline_item => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested timeline_item" do
        TimelineItem.should_receive(:find).with("37").and_return(mock_timeline_item)
        mock_timeline_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :timeline_item => {:these => 'params'}
      end

      it "assigns the requested timeline_item as @timeline_item" do
        TimelineItem.stub!(:find).and_return(mock_timeline_item(:update_attributes => true))
        put :update, :id => "1"
        assigns[:timeline_item].should equal(mock_timeline_item)
      end

      it "redirects to the timeline_item" do
        TimelineItem.stub!(:find).and_return(mock_timeline_item(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(timeline_item_url(mock_timeline_item))
      end
    end

    describe "with invalid params" do
      it "updates the requested timeline_item" do
        TimelineItem.should_receive(:find).with("37").and_return(mock_timeline_item)
        mock_timeline_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :timeline_item => {:these => 'params'}
      end

      it "assigns the timeline_item as @timeline_item" do
        TimelineItem.stub!(:find).and_return(mock_timeline_item(:update_attributes => false))
        put :update, :id => "1"
        assigns[:timeline_item].should equal(mock_timeline_item)
      end

      it "re-renders the 'edit' template" do
        TimelineItem.stub!(:find).and_return(mock_timeline_item(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested timeline_item" do
      TimelineItem.should_receive(:find).with("37").and_return(mock_timeline_item)
      mock_timeline_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the timeline_items list" do
      TimelineItem.stub!(:find).and_return(mock_timeline_item(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(timeline_items_url)
    end
  end

end

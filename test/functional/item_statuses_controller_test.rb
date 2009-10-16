require 'test_helper'

class ItemStatusesControllerTest < ActionController::TestCase
  
  setup :activate_authlogic    
  
  context "index action" do
    should "render index template" do
      UserSession.create(users(:admin))
      get :index
      assert_template 'index'
    end
  end
  
  context "show action" do
    should "render show template" do
      UserSession.create(users(:admin))
      get :show, :id => ItemStatus.first
      assert_template 'show'
    end
  end
  
  context "new action" do
    setup do
      UserSession.create(users(:admin))
    end
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end
  
  context "create action" do
    setup do
      UserSession.create(users(:admin))
    end
    should "render new template when model is invalid" do
      ItemStatus.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
    
    should "redirect when model is valid" do
      ItemStatus.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to item_status_url(assigns(:item_status))
    end
  end
  
  context "edit action" do
    setup do
      UserSession.create(users(:admin))
    end
    should "render edit template" do
      get :edit, :id => ItemStatus.first
      assert_template 'edit'
    end
  end
  
  context "update action" do
    setup do
      UserSession.create(users(:admin))
    end
    should "render edit template when model is invalid" do
      ItemStatus.any_instance.stubs(:valid?).returns(false)
      put :update, :id => ItemStatus.first
      assert_template 'edit'
    end
  
    should "redirect when model is valid" do
      setup do
        UserSession.create(users(:admin))
      end
      ItemStatus.any_instance.stubs(:valid?).returns(true)
      put :update, :id => ItemStatus.first
      assert_redirected_to item_status_url(assigns(:item_status))
    end
  end
  
  context "destroy action" do
    setup do
      UserSession.create(users(:admin))
    end
    should "destroy model and redirect to index action" do
      item_status = ItemStatus.first
      delete :destroy, :id => item_status
      assert_redirected_to item_statuses_url
      assert !ItemStatus.exists?(item_status.id)
    end
  end
  
  context "create or update from timeline" do
    setup do
      UserSession.create(users(:user))
    end
    should "create status if no status already exists" do
      assert_difference('ItemStatus.count') do
        post :create_or_update, :item_id => items(:book_brief_wondrous).id, 
                                :status_id => statuses(:read).id, 
                                :user_id => users(:user)
        #debugger
      end
    end
    should "update status if status already exists" do
      #ItemStatus.any_instance.stubs(:valid?).returns(true)
      assert_no_difference('ItemStatus.count') do
        post :create_or_update, :item_id => items(:book_march).id, 
                                :status_id => statuses(:plan_to_read).id, 
                                :user_id => users(:user)
      end
    end
  end
end

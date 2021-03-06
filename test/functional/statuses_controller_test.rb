require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  
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
      get :show, :id => Status.first
      assert_template 'show'
    end
  end
  
  context "new action" do
    should "render new template" do
      UserSession.create(users(:admin))
      get :new
      assert_template 'new'
    end
  end
  
  context "create action" do
    should "render new template when model is invalid" do
      UserSession.create(users(:admin))
      Status.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
    
    should "redirect when model is valid" do
      UserSession.create(users(:admin))
      Status.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to status_url(assigns(:status))
    end
  end
  
  context "edit action" do
    should "render edit template" do
      UserSession.create(users(:admin))
      get :edit, :id => Status.first
      assert_template 'edit'
    end
  end
  
  context "update action" do
    should "render edit template when model is invalid" do
      UserSession.create(users(:admin))
      Status.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Status.first
      assert_template 'edit'
    end
  
    should "redirect when model is valid" do
      UserSession.create(users(:admin))
      Status.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Status.first
      assert_redirected_to status_url(assigns(:status))
    end
  end
  
  context "destroy action" do
    should "destroy model and redirect to index action" do
      UserSession.create(users(:admin))
      status = Status.first
      delete :destroy, :id => status
      assert_redirected_to statuses_url
      assert !Status.exists?(status.id)
    end
  end
end

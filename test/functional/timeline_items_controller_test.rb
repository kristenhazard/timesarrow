require File.dirname(__FILE__) + '/../test_helper'

class TimelineItemsControllerTest < ActionController::TestCase
  
  def setup
    activate_authlogic
    UserSession.create(users(:admin)) # logs a user in
  end 
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timeline_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timeline_item" do
    assert_difference('TimelineItem.count') do
      post :create, :timeline_item => { :item_id => 1,
                                        :timeline_id => 1 }
    end

    assert_redirected_to timeline_item_path(assigns(:timeline_item))
  end

  test "should show timeline_item" do
    get :show, :id => timeline_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => timeline_items(:one).to_param
    assert_response :success
  end

  test "should update timeline_item" do
    put :update, :id => timeline_items(:one).to_param, :timeline_item => { }
    assert_redirected_to timeline_item_path(assigns(:timeline_item))
  end

  test "should destroy timeline_item" do
    @request.env['HTTP_REFERER'] = 'http://localhost:3000/timelines/1/edit'
    assert_difference('TimelineItem.count', -1) do
      delete :destroy, :id => timeline_items(:one).to_param
    end
  end
end

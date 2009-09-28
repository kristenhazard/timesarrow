require File.dirname(__FILE__) + '/../test_helper'

class TimelinesControllerTest < ActionController::TestCase
  
  setup :activate_authlogic
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:timelines)
  end

  def test_should_get_new
    UserSession.create(users(:admin)) # logs a user in
    get :new
    assert_response :success
  end


  def test_should_create_timeline
    UserSession.create(users(:admin)) # logs a user in
    assert_difference('Timeline.count') do
      post :create, :timeline => { :name => 'Test',
                                   :category => 'Book',
                                   :subcategory => 'Awards',
                                   :featured => 0,
                                   :genre => 'Adventure' }
    end
    assert_redirected_to edit_timeline_path(assigns(:timeline))
  end

  def test_should_show_timeline
    get :show, :id => timelines(:pulitzers).to_param
    assert_response :success
  end

  def test_should_get_edit
    UserSession.create(users(:admin)) # logs a user in
    get :edit, :id => timelines(:pulitzers).to_param
    assert_response :success
  end

  def test_should_update_timeline
    UserSession.create(users(:admin)) # logs a user in
    put :update, :id => timelines(:pulitzers).to_param, :timeline => { :name => 'Test',
                                                                 :category => 'Book',
                                                                 :subcategory => 'Awards',
                                                                 :featured => 0,
                                                                 :genre => 'Adventure' }
    assert_redirected_to timeline_path(assigns(:timeline))
  end

  def test_should_destroy_timeline
    UserSession.create(users(:admin)) # logs a user in
    assert_difference('Timeline.count', -1) do
      delete :destroy, :id => timelines(:pulitzers).to_param
    end

    assert_redirected_to timelines_path
  end
end

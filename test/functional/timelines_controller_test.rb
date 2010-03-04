require File.dirname(__FILE__) + '/../test_helper'

class TimelinesControllerTest < ActionController::TestCase
  
  setup :activate_authlogic
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_should_get_index_with_search_parameters
    get :index, {:search => 'Pulitzer', :page => nil}
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_user_should_get_index
    UserSession.create(users(:user))
    get :index
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_admin_should_get_index
    UserSession.create(users(:admin))
    get :index
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_should_get_featured
    get :featured
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_user_should_get_featured
    UserSession.create(users(:user))
    get :featured
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_admin_should_get_featured
    UserSession.create(users(:admin))
    get :featured
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_should_get_filtered
    get :filtered, {:category => 'book', :subcategory => 'awards'}
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_user_should_get_filtered
    UserSession.create(users(:user))
    get :filtered, {:category => 'book', :subcategory => 'awards'}
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_admin_should_get_filtered
    UserSession.create(users(:admin))
    get :filtered, {:category => 'book', :subcategory => 'awards'}
    assert_response :success
    assert_not_nil assigns(:timelines)
  end
  
  def test_should_get_filtered_genre
    get :filtered, {:category => 'book', :subcategory => 'awards', :genre => 'fiction' }
    assert_response :success
    assert_not_nil assigns(:timelines)
  end

  def test_admin_should_get_new
    UserSession.create(users(:admin))
    get :new
    assert_response :success
  end
  
  def test_user_should_get_new
    UserSession.create(users(:user))
    get :new
    assert_response :success
  end
  
  def test_not_logged_in_should_not_get_new
    get :new
    assert_redirected_to :login
  end


  def test_admin_should_create_timeline
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
  
  def test_user_should_create_timeline
    UserSession.create(users(:user)) # logs a user in
    assert_difference('Timeline.count') do
      post :create, :timeline => { :name => 'Test',
                                   :category => 'Book',
                                   :subcategory => 'Awards',
                                   :featured => 0,
                                   :genre => 'Adventure' }
    end
    assert_redirected_to edit_timeline_path(assigns(:timeline))
  end
  
  def test_not_logged_in_should_not_create_timeline
    post :create, :timeline => { :name => 'Test',
                                 :category => 'Book',
                                 :subcategory => 'Awards',
                                 :featured => 0,
                                 :genre => 'Adventure' }
    assert_redirected_to :login
  end


  def test_not_logged_in_should_show_timeline
    get :show, :id => timelines(:awards_fiction_featured).to_param
    assert_response :success
    assert_no_tag :tag => "ul", :attributes => { :id => "star-ratings-block" }
    assert_no_tag :tag => "select", :attributes => { :id => "item_current_statusid" }
    assert_no_tag :tag => "textarea", :attributes => { :id => "item_reviews_attributes_0_content" }
  end
  
  def test_user_should_show_timeline_with_interactions
    UserSession.create(users(:user))
    get :show, :id => timelines(:awards_fiction_featured).to_param
    assert_response :success
    # check for rateable functionality here
    assert_tag :tag => "ul", :attributes => { :class => "star-rating" }
    assert_tag :tag => "select", :attributes => { :id => "item_current_statusid" }
    assert_tag :tag => "textarea", :attributes => { :id => "item_reviews_attributes_0_content" }
  end
  
  def test_admin_should_show_timeline
    UserSession.create(users(:admin))
    get :show, :id => timelines(:awards_fiction_featured).to_param
    assert_response :success
  end
  
  def test_show_timeline_with_valid_item_id_parameter
    get :show, :id => timelines(:awards_fiction_featured).to_param, :item_id => items(:book_march).to_param
    assert_response :success
  end
  
  def test_show_timeline_with_invalid_item_id_parameter
    get :show, :id => timelines(:awards_fiction_featured).to_param, :item_id => items(:book_not_in_timeline).to_param
    assert_response :redirect
  end
  
  


  def test_admin_should_get_edit
    UserSession.create(users(:admin)) # logs a user in
    get :edit, :id => timelines(:awards_fiction_featured).to_param
    assert_response :success
  end
  
  def test_user_should_get_edit_only_if_owner_of_timeline
    UserSession.create(users(:user))
    get :edit, :id => timelines(:awards_fiction_featured).to_param
    assert_response :success
  end
  
  def test_user_should_not_get_edit_if_not_owner_of_timeline
    UserSession.create(users(:user))
    get :edit, :id => timelines(:awards_nonfiction_not_featured).to_param
    #assert_redirected_to timeline_path(assigns(timelines(:awards_nonfiction_not_featured)))
    assert_equal 'You can only edit timelines you have created.', flash[:notice]
  end
  
  def test_not_logged_in_should_not_get_edit
    get :edit, :id => timelines(:awards_fiction_featured).to_param
    assert_redirected_to :login
  end

  def test_admin_should_update_timeline
    UserSession.create(users(:admin)) # logs a user in
    put :update, :id => timelines(:awards_fiction_featured).to_param, :timeline => { :name => 'Test',
                                                                 :category => 'Book',
                                                                 :subcategory => 'Awards',
                                                                 :featured => 0,
                                                                 :genre => 'Adventure' }
    assert_redirected_to timeline_path(assigns(:timeline))
  end

  def test_admin_should_destroy_timeline
    UserSession.create(users(:admin)) # logs a user in
    assert_difference('Timeline.count', -1) do
      delete :destroy, :id => timelines(:awards_fiction_featured).to_param
    end

    assert_redirected_to timelines_path
  end
  

end

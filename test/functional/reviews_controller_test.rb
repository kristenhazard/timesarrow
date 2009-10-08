require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  
  setup :activate_authlogic
  
  
  
  def test_should_get_index
    UserSession.create(users(:admin))
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end
  
  
  
  def test_index
    UserSession.create(users(:admin))
    get :index
    assert_template 'index'
  end
  
  def test_show
    UserSession.create(users(:admin))
    get :show, :id => Review.first
    assert_template 'show'
  end
  
  def test_new
    UserSession.create(users(:admin))
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    UserSession.create(users(:admin))
    Review.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    UserSession.create(users(:admin))
    Review.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to review_url(assigns(:review))
  end
  
  def test_edit
    UserSession.create(users(:admin))
    get :edit, :id => Review.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    UserSession.create(users(:admin))
    Review.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Review.first
    assert_template 'edit'
  end
  
  def test_update_valid
    UserSession.create(users(:admin))
    Review.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Review.first
    assert_redirected_to review_url(assigns(:review))
  end
  
  def test_destroy
    UserSession.create(users(:admin))
    review = Review.first
    delete :destroy, :id => review
    assert_redirected_to reviews_url
    assert !Review.exists?(review.id)
  end
end

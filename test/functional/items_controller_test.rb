require File.dirname(__FILE__) + '/../test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, :item => { :title => 'March', 
                               :asin => '1111111111', 
                               :detailpageurl => 'http://amazon.com',
                               :category_id => categories(:book) }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, :id => items(:book_march).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => items(:book_march).to_param
    assert_response :success
  end

  test "should update item" do
    put :update, :id => items(:book_march).to_param, :item => { :title => 'March2' }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :id => items(:book_march).to_param
    end

    assert_redirected_to items_path
  end
end

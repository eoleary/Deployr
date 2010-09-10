require 'test_helper'

class GhPushesControllerTest < ActionController::TestCase
  setup do
    @gh_push = gh_pushes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gh_pushes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gh_push" do
    assert_difference('GhPush.count') do
      post :create, :gh_push => @gh_push.attributes
    end

    assert_redirected_to gh_push_path(assigns(:gh_push))
  end

  test "should show gh_push" do
    get :show, :id => @gh_push.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @gh_push.to_param
    assert_response :success
  end

  test "should update gh_push" do
    put :update, :id => @gh_push.to_param, :gh_push => @gh_push.attributes
    assert_redirected_to gh_push_path(assigns(:gh_push))
  end

  test "should destroy gh_push" do
    assert_difference('GhPush.count', -1) do
      delete :destroy, :id => @gh_push.to_param
    end

    assert_redirected_to gh_pushes_path
  end
end

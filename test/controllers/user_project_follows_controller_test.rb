require 'test_helper'

class UserProjectFollowsControllerTest < ActionController::TestCase
  setup do
    @user_project_follow = user_project_follows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_project_follows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_project_follow" do
    assert_difference('UserProjectFollow.count') do
      post :create, user_project_follow: { project_id: @user_project_follow.project_id, user_id: @user_project_follow.user_id }
    end

    assert_redirected_to user_project_follow_path(assigns(:user_project_follow))
  end

  test "should show user_project_follow" do
    get :show, id: @user_project_follow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_project_follow
    assert_response :success
  end

  test "should update user_project_follow" do
    patch :update, id: @user_project_follow, user_project_follow: { project_id: @user_project_follow.project_id, user_id: @user_project_follow.user_id }
    assert_redirected_to user_project_follow_path(assigns(:user_project_follow))
  end

  test "should destroy user_project_follow" do
    assert_difference('UserProjectFollow.count', -1) do
      delete :destroy, id: @user_project_follow
    end

    assert_redirected_to user_project_follows_path
  end
end

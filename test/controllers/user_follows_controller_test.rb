require 'test_helper'

class UserFollowsControllerTest < ActionController::TestCase
  setup do
    @user_follow = user_follows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_follows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_follow" do
    assert_difference('UserFollow.count') do
      post :create, user_follow: { followee_id: @user_follow.followee_id, follower_id: @user_follow.follower_id }
    end

    assert_redirected_to user_follow_path(assigns(:user_follow))
  end

  test "should show user_follow" do
    get :show, id: @user_follow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_follow
    assert_response :success
  end

  test "should update user_follow" do
    patch :update, id: @user_follow, user_follow: { followee_id: @user_follow.followee_id, follower_id: @user_follow.follower_id }
    assert_redirected_to user_follow_path(assigns(:user_follow))
  end

  test "should destroy user_follow" do
    assert_difference('UserFollow.count', -1) do
      delete :destroy, id: @user_follow
    end

    assert_redirected_to user_follows_path
  end
end

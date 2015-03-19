require 'test_helper'

class UserToInterestsControllerTest < ActionController::TestCase
  setup do
    @user_to_interest = user_to_interests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_to_interests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_to_interest" do
    assert_difference('UserToInterest.count') do
      post :create, user_to_interest: { interest_id: @user_to_interest.interest_id, user_id: @user_to_interest.user_id }
    end

    assert_redirected_to user_to_interest_path(assigns(:user_to_interest))
  end

  test "should show user_to_interest" do
    get :show, id: @user_to_interest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_to_interest
    assert_response :success
  end

  test "should update user_to_interest" do
    patch :update, id: @user_to_interest, user_to_interest: { interest_id: @user_to_interest.interest_id, user_id: @user_to_interest.user_id }
    assert_redirected_to user_to_interest_path(assigns(:user_to_interest))
  end

  test "should destroy user_to_interest" do
    assert_difference('UserToInterest.count', -1) do
      delete :destroy, id: @user_to_interest
    end

    assert_redirected_to user_to_interests_path
  end
end

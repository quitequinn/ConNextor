require 'test_helper'

class ProfileIntroductionsControllerTest < ActionController::TestCase
  setup do
    @profile_introduction = profile_introductions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_introductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_introduction" do
    assert_difference('ProfileIntroduction.count') do
      post :create, profile_introduction: { body: @profile_introduction.body, profile_id: @profile_introduction.profile_id }
    end

    assert_redirected_to profile_introduction_path(assigns(:profile_introduction))
  end

  test "should show profile_introduction" do
    get :show, id: @profile_introduction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_introduction
    assert_response :success
  end

  test "should update profile_introduction" do
    patch :update, id: @profile_introduction, profile_introduction: { body: @profile_introduction.body, profile_id: @profile_introduction.profile_id }
    assert_redirected_to profile_introduction_path(assigns(:profile_introduction))
  end

  test "should destroy profile_introduction" do
    assert_difference('ProfileIntroduction.count', -1) do
      delete :destroy, id: @profile_introduction
    end

    assert_redirected_to profile_introductions_path
  end
end

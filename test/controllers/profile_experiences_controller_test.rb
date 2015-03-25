require 'test_helper'

class ProfileExperiencesControllerTest < ActionController::TestCase
  setup do
    @profile_experience = profile_experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_experience" do
    assert_difference('ProfileExperience.count') do
      post :create, profile_experience: { description: @profile_experience.description, from_date: @profile_experience.from_date, name: @profile_experience.name, position: @profile_experience.position, profile_id: @profile_experience.profile_id, to_date: @profile_experience.to_date }
    end

    assert_redirected_to profile_experience_path(assigns(:profile_experience))
  end

  test "should show profile_experience" do
    get :show, id: @profile_experience
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_experience
    assert_response :success
  end

  test "should update profile_experience" do
    patch :update, id: @profile_experience, profile_experience: { description: @profile_experience.description, from_date: @profile_experience.from_date, name: @profile_experience.name, position: @profile_experience.position, profile_id: @profile_experience.profile_id, to_date: @profile_experience.to_date }
    assert_redirected_to profile_experience_path(assigns(:profile_experience))
  end

  test "should destroy profile_experience" do
    assert_difference('ProfileExperience.count', -1) do
      delete :destroy, id: @profile_experience
    end

    assert_redirected_to profile_experiences_path
  end
end

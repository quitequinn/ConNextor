require 'test_helper'

class UserToProjectsControllerTest < ActionController::TestCase
  setup do
    @user_to_project = user_to_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_to_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_to_project" do
    assert_difference('UserToProject.count') do
      post :create, user_to_project: { project_id: @user_to_project.project_id, project_user_class_id: @user_to_project.project_user_class_id, user_id: @user_to_project.user_id }
    end

    assert_redirected_to user_to_project_path(assigns(:user_to_project))
  end

  test "should show user_to_project" do
    get :show, id: @user_to_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_to_project
    assert_response :success
  end

  test "should update user_to_project" do
    patch :update, id: @user_to_project, user_to_project: { project_id: @user_to_project.project_id, project_user_class_id: @user_to_project.project_user_class_id, user_id: @user_to_project.user_id }
    assert_redirected_to user_to_project_path(assigns(:user_to_project))
  end

  test "should destroy user_to_project" do
    assert_difference('UserToProject.count', -1) do
      delete :destroy, id: @user_to_project
    end

    assert_redirected_to user_to_projects_path
  end
end

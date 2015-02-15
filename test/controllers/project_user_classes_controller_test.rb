require 'test_helper'

class ProjectUserClassesControllerTest < ActionController::TestCase
  setup do
    @project_user_class = project_user_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_user_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_user_class" do
    assert_difference('ProjectUserClass.count') do
      post :create, project_user_class: { name: @project_user_class.name }
    end

    assert_redirected_to project_user_class_path(assigns(:project_user_class))
  end

  test "should show project_user_class" do
    get :show, id: @project_user_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_user_class
    assert_response :success
  end

  test "should update project_user_class" do
    patch :update, id: @project_user_class, project_user_class: { name: @project_user_class.name }
    assert_redirected_to project_user_class_path(assigns(:project_user_class))
  end

  test "should destroy project_user_class" do
    assert_difference('ProjectUserClass.count', -1) do
      delete :destroy, id: @project_user_class
    end

    assert_redirected_to project_user_classes_path
  end
end

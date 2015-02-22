require 'test_helper'

class UserToProjectTasksControllerTest < ActionController::TestCase
  setup do
    @user_to_project_task = user_to_project_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_to_project_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_to_project_task" do
    assert_difference('UserToProjectTask.count') do
      post :create, user_to_project_task: { project_task_id: @user_to_project_task.project_task_id, relation: @user_to_project_task.relation, user_id: @user_to_project_task.user_id }
    end

    assert_redirected_to user_to_project_task_path(assigns(:user_to_project_task))
  end

  test "should show user_to_project_task" do
    get :show, id: @user_to_project_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_to_project_task
    assert_response :success
  end

  test "should update user_to_project_task" do
    patch :update, id: @user_to_project_task, user_to_project_task: { project_task_id: @user_to_project_task.project_task_id, relation: @user_to_project_task.relation, user_id: @user_to_project_task.user_id }
    assert_redirected_to user_to_project_task_path(assigns(:user_to_project_task))
  end

  test "should destroy user_to_project_task" do
    assert_difference('UserToProjectTask.count', -1) do
      delete :destroy, id: @user_to_project_task
    end

    assert_redirected_to user_to_project_tasks_path
  end
end

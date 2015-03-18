require 'test_helper'

class ProjectPostsControllerTest < ActionController::TestCase
  setup do
    @project_post = project_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_post" do
    assert_difference('ProjectPost.count') do
      post :create, project_post: { project_id: @project_post.project_id, text: @project_post.text, user_id: @project_post.user_id }
    end

    assert_redirected_to project_post_path(assigns(:project_post))
  end

  test "should show project_post" do
    get :show, id: @project_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_post
    assert_response :success
  end

  test "should update project_post" do
    patch :update, id: @project_post, project_post: { project_id: @project_post.project_id, text: @project_post.text, user_id: @project_post.user_id }
    assert_redirected_to project_post_path(assigns(:project_post))
  end

  test "should destroy project_post" do
    assert_difference('ProjectPost.count', -1) do
      delete :destroy, id: @project_post
    end

    assert_redirected_to project_posts_path
  end
end

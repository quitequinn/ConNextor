require 'test_helper'

class ProjectTagsControllerTest < ActionController::TestCase
  setup do
    @project_tag = project_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_tag" do
    assert_difference('ProjectTag.count') do
      post :create, project_tag: { name: @project_tag.name }
    end

    assert_redirected_to project_tag_path(assigns(:project_tag))
  end

  test "should show project_tag" do
    get :show, id: @project_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_tag
    assert_response :success
  end

  test "should update project_tag" do
    patch :update, id: @project_tag, project_tag: { name: @project_tag.name }
    assert_redirected_to project_tag_path(assigns(:project_tag))
  end

  test "should destroy project_tag" do
    assert_difference('ProjectTag.count', -1) do
      delete :destroy, id: @project_tag
    end

    assert_redirected_to project_tags_path
  end
end

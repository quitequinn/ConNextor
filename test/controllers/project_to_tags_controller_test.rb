require 'test_helper'

class ProjectToTagsControllerTest < ActionController::TestCase
  setup do
    @project_to_tag = project_to_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_to_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_to_tag" do
    assert_difference('ProjectToTag.count') do
      post :create, project_to_tag: { project_id: @project_to_tag.project_id, project_tag_id: @project_to_tag.project_tag_id }
    end

    assert_redirected_to project_to_tag_path(assigns(:project_to_tag))
  end

  test "should show project_to_tag" do
    get :show, id: @project_to_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_to_tag
    assert_response :success
  end

  test "should update project_to_tag" do
    patch :update, id: @project_to_tag, project_to_tag: { project_id: @project_to_tag.project_id, project_tag_id: @project_to_tag.project_tag_id }
    assert_redirected_to project_to_tag_path(assigns(:project_to_tag))
  end

  test "should destroy project_to_tag" do
    assert_difference('ProjectToTag.count', -1) do
      delete :destroy, id: @project_to_tag
    end

    assert_redirected_to project_to_tags_path
  end
end

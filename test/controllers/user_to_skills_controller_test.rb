require 'test_helper'

class UserToSkillsControllerTest < ActionController::TestCase
  setup do
    @user_to_skill = user_to_skills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_to_skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_to_skill" do
    assert_difference('UserToSkill.count') do
      post :create, user_to_skill: { skill_id: @user_to_skill.skill_id, user_id: @user_to_skill.user_id }
    end

    assert_redirected_to user_to_skill_path(assigns(:user_to_skill))
  end

  test "should show user_to_skill" do
    get :show, id: @user_to_skill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_to_skill
    assert_response :success
  end

  test "should update user_to_skill" do
    patch :update, id: @user_to_skill, user_to_skill: { skill_id: @user_to_skill.skill_id, user_id: @user_to_skill.user_id }
    assert_redirected_to user_to_skill_path(assigns(:user_to_skill))
  end

  test "should destroy user_to_skill" do
    assert_difference('UserToSkill.count', -1) do
      delete :destroy, id: @user_to_skill
    end

    assert_redirected_to user_to_skills_path
  end
end

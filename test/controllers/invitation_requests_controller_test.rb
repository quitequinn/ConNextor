require 'test_helper'

class InvitationRequestsControllerTest < ActionController::TestCase
  setup do
    @invitation_request = invitation_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invitation_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invitation_request" do
    assert_difference('InvitationRequest.count') do
      post :create, invitation_request: { email: @invitation_request.email, expertise: @invitation_request.expertise, github: @invitation_request.github, linkedin: @invitation_request.linkedin, message: @invitation_request.message, name: @invitation_request.name, portfolio: @invitation_request.portfolio }
    end

    assert_redirected_to invitation_request_path(assigns(:invitation_request))
  end

  test "should show invitation_request" do
    get :show, id: @invitation_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invitation_request
    assert_response :success
  end

  test "should update invitation_request" do
    patch :update, id: @invitation_request, invitation_request: { email: @invitation_request.email, expertise: @invitation_request.expertise, github: @invitation_request.github, linkedin: @invitation_request.linkedin, message: @invitation_request.message, name: @invitation_request.name, portfolio: @invitation_request.portfolio }
    assert_redirected_to invitation_request_path(assigns(:invitation_request))
  end

  test "should destroy invitation_request" do
    assert_difference('InvitationRequest.count', -1) do
      delete :destroy, id: @invitation_request
    end

    assert_redirected_to invitation_requests_path
  end
end

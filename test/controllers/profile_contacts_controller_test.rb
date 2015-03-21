require 'test_helper'

class ProfileContactsControllerTest < ActionController::TestCase
  setup do
    @profile_contact = profile_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_contact" do
    assert_difference('ProfileContact.count') do
      post :create, profile_contact: { link: @profile_contact.link, name: @profile_contact.name, profile_id: @profile_contact.profile_id, type: @profile_contact.type }
    end

    assert_redirected_to profile_contact_path(assigns(:profile_contact))
  end

  test "should show profile_contact" do
    get :show, id: @profile_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_contact
    assert_response :success
  end

  test "should update profile_contact" do
    patch :update, id: @profile_contact, profile_contact: { link: @profile_contact.link, name: @profile_contact.name, profile_id: @profile_contact.profile_id, type: @profile_contact.type }
    assert_redirected_to profile_contact_path(assigns(:profile_contact))
  end

  test "should destroy profile_contact" do
    assert_difference('ProfileContact.count', -1) do
      delete :destroy, id: @profile_contact
    end

    assert_redirected_to profile_contacts_path
  end
end

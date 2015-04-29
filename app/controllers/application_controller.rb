require 'net/https'
require "uri"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include PermissionsHelper

  helper_method :current_user, :current_user?, :logged_in?, :current_user_id, :phase_active?

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end

  def current_user_id
    session[:user_id]
  end

  def make_asana_request(url, token)
    uri = URI.parse( url )
    http = Net::HTTP.new( uri.host, uri.port )
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"Authorization" => "Bearer #{token}"})
    response = http.request(request)

    # I believe this displays non UTF-8 characters
    result = response.body.force_encoding('ISO-8859-1')
  end

  def workspaces( token )
    url = ASANA::API_URL + "/workspaces"
    make_asana_request( url, token )
  end

  def workspace_projects( workspace_id, token )
    url = ASANA::API_URL + "/workspaces/#{workspace_id}/projects"
    make_asana_request( url, token )
  end

  def project( project_id, token )
    url = ASANA::API_URL + "/projects/#{project_id}"
    make_asana_request( url, token )
  end

  def workspace_users( workspace_id, token )
    url = ASANA::API_URL + "/workspaces/#{workspace_id}/users"
    make_asana_request( url, token )
  end

  def current_asana_user( token )
    url = ASANA::API_URL + "/users/me"
    make_asana_request( url, token )
  end

  def get_asana_task( task_id, token )
    url = ASANA::API_URL + "/tasks/#{task_id}"
    make_asana_request( url, token )
  end

  def project_tasks( project_id, token )
    url = ASANA::API_URL + "/projects/#{project_id}/tasks"
    make_asana_request( url, token )
  end

  def workspace_tasks( workspace_id, token )
    url = ASANA::API_URL + "/workspaces/#{workspace_id}/tasks"
    make_asana_request( url, token )
  end

  def tag( tag_id, token )
    url = ASANA::API_URL + "/tags/#{tag_id}"
    make_asana_request( url, token )
  end

  def tag_tasks (tag_id, token )
    url = ASANA::API_URL + "/tags/#{tag_id}/tasks"
    make_asana_request( url, token )
  end

  def workspace_tags( workspace_id, token )
    url = ASANA::API_URL + "/workspaces/#{workspace_id}/tags"
    make_asana_request( url, token )
  end

  def phase_active?(array)
    array.include? ProjectMeta::CURRENT_PHASE
  end

  private

  def set_user_project_env
    if logged_in?
      # user_to_project
      @user_to_project = UserToProject.find_by user: current_user, project: @project
      if @user_to_project
        @is_owner = @user_to_project.project_user_class == ProjectUserClass::OWNER
        @is_core_member = @user_to_project.project_user_class == ProjectUserClass::CORE_MEMBER
        @is_contributor = @user_to_project.project_user_class == ProjectUserClass::CONTRIBUTOR
      end
    end
  end
end

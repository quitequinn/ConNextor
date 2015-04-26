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

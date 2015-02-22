class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #helper_method :current_user

  #private

  #def current_user
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end

  private

  def set_user_project_env
    @user_logged_in = logged_in?
    if @user_logged_in
      @current_user = current_user

      # project
      begin
        @project = Project.find params[:project] # might throw exception
      rescue ActiveRecord::RecordNotFound
      end

      # user_to_project
      @user_to_project = UserToProject.find_by user: @current_user, project: @project
      if @user_to_project
        @is_owner = @user_to_project.project_user_class == ProjectUserClass::OWNER
        @is_core_member = @user_to_project.project_user_class == ProjectUserClass::CORE_MEMBER
        @is_contributor = @user_to_project.project_user_class == ProjectUserClass::CONTRIBUTOR
      end
    end
  end
end

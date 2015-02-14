class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:new] 
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Created project!"
      redirect_to root_url
    else
      render "new"
    end
  end


  def index
    @allprojects = Project.paginate(page: params[:page])
  end


  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Profile updated"
      redirect_to @project
    else
      render 'edit'
    end
  end


  def show
    @project = Project.find(params[:id])
  end  

  
  private
  
  def project_params
    params.require(:project).permit(:name, :description )
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to log_in_url
    end
  end



  # Confirms a logged-in project.
  def logged_in_project
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to log_in_url
    end
  end
  
end

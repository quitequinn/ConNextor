class UserToProjectsController < ApplicationController
  before_action :set_user_to_project, only: [:show, :edit, :update, :destroy]

  def index
    set_user_project_env
    # Security Clearance
    if @user_to_project and @is_owner
      @user_to_projects = @project.user_to_projects
    end
  end

  def show
  end

  def new
    @user_to_project = UserToProject.new
  end

  def edit
  end

  def create
    @user_to_project = UserToProject.new(user_to_project_params)

    respond_to do |format|
      if @user_to_project.save
        format.html { redirect_to @user_to_project.project, notice: 'New Entry for User Project Relationship' }
        format.json { render :show, status: :created, location: @user_to_project }
      else
        format.html { render :new }
        format.json { render json: @user_to_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update # need more work
    respond_to do |format|
      if @user_to_project.update(user_to_project_params)
        format.html { redirect_to @user_to_project.project, notice: 'User Class updated.' }
        format.json { render :show, status: :ok, location: @user_to_project }
      else
        format.html { render :edit }
        format.json { render json: @user_to_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_to_project.destroy
    respond_to do |format|
      format.html { redirect_to user_to_projects_url, notice: 'User to project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user_to_project
      @user_to_project = UserToProject.find(params[:id])
    end

    def user_to_project_params
      params.require(:user_to_project).permit(:user_id, :project_id, :project_user_class)
    end

end

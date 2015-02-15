class UserToProjectsController < ApplicationController
  before_action :set_user_to_project, only: [:show, :edit, :update, :destroy]

  # GET /user_to_projects
  # GET /user_to_projects.json
  def index
    @user_to_projects = UserToProject.all
  end

  # GET /user_to_projects/1
  # GET /user_to_projects/1.json
  def show
  end

  # GET /user_to_projects/new
  def new
    @user_to_project = UserToProject.new
  end

  # GET /user_to_projects/1/edit
  def edit
  end

  # POST /user_to_projects
  # POST /user_to_projects.json
  def create
    @user = current_user
    # logger.error "Got User: #{@user.id}"
    project = Project.find(params[:project_id])
    # logger.error "Got Project: #{project.id}"
    project_user_class = ProjectUserClass.find_by_name params[:method]
    # logger.error "Got Project User Class: #{project_user_class.id}"

    # @user_to_project = UserToProject.new(user_to_project_params)
    @user_to_project = @user.user_to_projects.build(project: project, project_user_class: project_user_class)
    # logger.error "Built User To Project: #{@user_to_project.id}"

    respond_to do |format|
      if @user_to_project.save
        format.html { redirect_to @user_to_project.project, notice: 'Project followed' }
        format.json { render :show, status: :created, location: @user_to_project }
      else
        format.html { render :new }
        format.json { render json: @user_to_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_to_projects/1
  # PATCH/PUT /user_to_projects/1.json
  def update
    respond_to do |format|
      if @user_to_project.update(user_to_project_params)
        format.html { redirect_to @user_to_project, notice: 'User to project was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_to_project }
      else
        format.html { render :edit }
        format.json { render json: @user_to_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_to_projects/1
  # DELETE /user_to_projects/1.json
  def destroy
    @user_to_project.destroy
    respond_to do |format|
      format.html { redirect_to user_to_projects_url, notice: 'User to project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_to_project
      @user_to_project = UserToProject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_to_project_params
      params.require(:user_to_project).permit(:user_id, :project_id, :project_user_class_id)
    end
end

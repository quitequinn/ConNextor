class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_user_project_env, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    user_id = current_user_id # might be nil
    project_user_class = ProjectUserClass.find_by_name 'Ownership' # might also throw exception

    @user_to_project = UserToProject.new(user_id: user_id, project_id: @project.id, project_user_class: project_user_class)
    @user_to_project.save

    respond_to do |format|
      if @project.save
        # add ownership for current_user
        @user_to_project = UserToProject.new(user_id: user_id, project_id: @project.id, project_user_class: project_user_class)
        if @user_to_project.save
          format.html { redirect_to @project, notice: 'Project was successfully created.' }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_user_project_env
      @user_logged_in = logged_in?
      if @user_logged_in
        @current_user = current_user

        # user_project_follow
        @user_project_follow = UserProjectFollow.find_by user: @current_user, project: @project

        # user_to_project
        @user_to_project = UserToProject.find_by user: @current_user, project: @project

        # project_user_class
        @project_user_class = ProjectUserClass.find @user_to_project.project_user_class
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :short_description, :long_description)
    end
end

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_user_project_env, only: [:show, :edit, :update, :destroy]
  before_action :set_user_project_follow, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @positions = @project.positions
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def join_request
    sender_id = join_request_params[:user_id]
    project_id = join_request_params[:project_id]
    position_id = join_request_params[:position_id]
    project_owner = UserToProject.find_by_project_id_and_project_user_class(project_id,ProjectUserClass::OWNER)
    Notification.create(receiver_id: project_owner.user_id, 
                        sender_id: sender_id,
                        project_id: project_id,
                        position_id: position_id,
                        message: "Hi, I would like to join your project", 
                        link: "/users/#{sender_id}")

    javascript = "alert('There is a person who wants to join your project');"
    PrivatePub.publish_to("/inbox/#{project_owner.user_id}",javascript)
    redirect_to Project.find(project_id)
  end

  def accept_request
    user_id = accept_request_params[:user_id]
    project_id = accept_request_params[:project_id]
    position_id = accept_request_params[:position_id]
    link = accept_request_params[:link]
    @project = Project.find(project_id)
    UserToProject.create( user_id: user_id, 
                          project_id: project_id, 
                          project_user_class: ProjectUserClass::CORE_MEMBER )

    Position.update(position_id, filled: true)
    Notification.create(receiver_id: user_id, 
                        sender_id: current_user_id, 
                        message: "You have enjoyed a project", 
                        link: "/projects/#{project_id}")

    javascript = "alert('You have successfully joined #{@project.id}');"
    PrivatePub.publish_to("/inbox/#{user_id}",javascript)
    redirect_to Project.find(project_id)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    user_id = current_user_id # might be nil
    project_user_class = ProjectUserClass::OWNER

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
    begin
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempted access to invalid project #{params[:id]}"
      redirect_to projects_url, notice: 'Invalid project, please try again.'
    end
  end

  def set_user_project_follow
    # user_project_follow
    @user_project_follow = UserProjectFollow.find_by user: @current_user, project: @project
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:title, :short_description, :long_description)
  end

  def join_request_params
    params.permit(:user_id, :project_id, :position_id)
  end

  def accept_request_params
    params.permit(:user_id, :project_id, :position_id, :link)
  end

end

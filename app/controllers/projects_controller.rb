class ProjectsController < ApplicationController
  before_action :set_project, only: [:switch, :show, :edit, :update, :destroy, :manage, :core_project] 
  before_action :get_user_access, only: [:switch, :show] 

  def index
    @projects = Project.all
  end

  def show
    @activities = Activity.where( parent_id: @project.id )
    @user_project_follow = UserProjectFollow.find_by_user_id_and_project_id(current_user_id, @project.id)
  end

  def manage
    session[:return_to] = @project.id
    @stages = ProjectStage::STAGES
    @has_project_permission = has_project_permission?(current_user_id, @project.id)
  end

  def core_project
    access = has_project_permission?(current_user_id, @project.id)

    asana_identity = AsanaIdentity.find_by_user_id( current_user_id )
    token = asana_identity.access_token
    @asana_projects = AsanaProject.where(project_id: @project.id )

    if @asana_projects
      @asana_tasks = AsanaTask.where(workspace_id: workspace_id)

      ### Update projects and tasks
            
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def switch
    @tab_name = params[:tab]
    @tab_name.downcase!
    respond_to do |format|
      format.js
    end
  end

  def join_request
    sender_id = join_request_params[:user_id]
    project_id = join_request_params[:project_id]
    position_id = join_request_params[:position_id]
    project_owner = UserToProject.find_by_project_id_and_project_user_class(project_id,ProjectUserClass::OWNER)
    Request.create( receiver_id: project_owner.user_id, 
                    sender_id: sender_id,
                    request_type: 'project_position',
                    request_type_id: position_id,
                    message: "Hi, I would like to join your project", 
                    link: "/users/#{sender_id}")

    javascript = "alert('There is a person who wants to join your project');"
    #PrivatePub.publish_to("/inbox/#{project_owner.user_id}",javascript)
    redirect_to Project.find(project_id)
  end

  def accept_request
    user_id = accept_request_params[:user_id]
    position_id = accept_request_params[:position_id]
    position = Position.find(position_id)
    project_id = position.project_id
    link = accept_request_params[:link]
    @project = Project.find(project_id)
    UserToProject.create( user_id: user_id, 
                          project_id: project_id, 
                          project_user_class: position.position_type )

    Position.update(position_id, filled: true, user_id: user_id)
    Notification.create( user_id: user_id, 
                         actor_id: current_user_id,
                         verb: 'joined project',
                         notification_type: 'ProjectPosition',
                         message: "You have enjoyed a project", 
                         link: "/projects/#{project_id}",
                         isRead: false )

    javascript = "alert('You have successfully joined #{@project.id}');"
    #PrivatePub.publish_to("/inbox/#{user_id}",javascript)
    redirect_to Project.find(project_id)
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        logger.error "CURRENT_USER_ID: #{current_user_id}, and PROJECT_ID: #{@project.id}"
         @user_to_project = UserToProject.new( user_id: current_user_id, 
                                               project_id: @project.id, 
                                               project_user_class: ProjectUserClass::OWNER)
        if @user_to_project.save
          format.html { redirect_to @project, notice: 'Project was successfully created.' }
          format.json { render :show, status: :created, location: @project }
        else
          logger.error 'User to Project save failed.'
          format.html { render :new }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

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

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
 
    def set_project
      begin
        @project = Project.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        logger.error "Attempted access to invalid project #{params[:id]}"
        redirect_to projects_url, notice: 'Invalid project, please try again.'
      end
    end

    def get_user_access
      @user_to_project = UserToProject.find_by user: current_user, project: @project
      if @user_to_project
        @is_owner = @user_to_project.project_user_class == ProjectUserClass::OWNER
        @is_core_member = @user_to_project.project_user_class == ProjectUserClass::CORE_MEMBER
        @is_contributor = @user_to_project.project_user_class == ProjectUserClass::CONTRIBUTOR
      end
    end

    def project_params
      params.require(:project).permit(
        :title,
        :short_description,
        :long_description,
        :stage )
    end

    def join_request_params
      params.permit(:user_id, :project_id, :position_id)
    end

    def accept_request_params
      params.permit(:user_id, :position_id, :link)
    end

    def fetch_asana_projects_tasks(asana_projects)
      # Add any new projects
      workspace_id = asana_projects[0].workspace_id
      new_asana_projects = JSON.parse workspace_projects(workspace_id, token)
      if new_asana_projects['data']
        new_asana_projects['data'].each do |new_asana_project|
          asana_project = AsanaProject.find_by_asana_project_id(new_asana_project['id'])
          if asana_project == nil
            asana_project_details = JSON.parse project(new_asana_project['id'],token)
            AsanaProject.create_asana_project(asana_project_details)
          else
            #Update method (future work)
          end
        end
      end

      # Add and update tasks
      asana_projects.each do |asana_project|
        tasks = JSON.parse project_tasks( asana_project.asana_project_id , token )
        if tasks['data']
          tasks['data'].each do |task|
            asana_task = AsanaTask.find_by_asana_task_id(task['id'])
            asana_task_details = JSON.parse get_asana_task(task['id'],token)
            if asana_task == nil
              AsanaTask.create_asana_task(asana_task_details['data'], asana_project.asana_project_id) 
            else
              asana_task.update_asana_task(asana_task_details['data'], asana_project.asana_project_id)
            end
          end
        end
      end
    end
end

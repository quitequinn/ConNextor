class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    project_id = params[:project_id]
    @has_project_permission = has_project_permission?(current_user_id, project_id)
    
    # change queries later
    @tasks = Task.where(project_id: project_id)
    @completed_tasks = @tasks.where(completed: true)
    @open_tasks = @tasks.where(assigned_to: nil)
    @filled_tasks = @tasks.where.not(assigned_to: nil)
  end

  def new
    check_user_permission(params[:project_id])
    @task = Task.new(completed: false)
    @user_to_projects = UserToProject.where(
      project_id: params[:project_id], 
      project_user_class: [ProjectUserClass::CORE_MEMBER, ProjectUserClass::OWNER] )
    @core_members = User.where(id: @user_to_projects.select(:user_id))
  end

  def create
    check_user_permission(params[:project_id])
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.project, notice: 'New task created!' }
      else
        format.html { render :new }
      end
    end
  end

  # Send notification to owner
  def join_request
    sender_id = join_request_params[:user_id]
    project_id = join_request_params[:project_id]
    task_id = join_request_params[:task_id]
    task_title = Task.find(task_id).title
    project_owner = UserToProject.find_by_project_id_and_project_user_class(project_id,ProjectUserClass::OWNER)
    Request.create( receiver_id: project_owner.user_id, 
                    sender_id: sender_id,
                    request_type: 'project_task',
                    request_type_id: task_id,
                    message: "Hi, I would like to take on task #{task_title}", 
                    link: "/users/#{sender_id}")

    javascript = "alert('There is a person who wants to take on a task');"
    #PrivatePub.publish_to("/inbox/#{project_owner.user_id}",javascript)
    redirect_to project_tasks_path(project_id), notice: 'Request sent!'
  end

  # Create user to task
  # Update task
  # Send notification
  def accept_request
    user_id = accept_request_params[:user_id]
    task_id = accept_request_params[:task_id]
    task = Task.find(task_id)
    project_id = task.project_id
    link = accept_request_params[:link]
    @project = Project.find(project_id)
    UserToTask.create(  user_id: user_id, 
                        task_id: task_id,
                        status: ProjectTaskState::ASSIGNED )

    task.update(assigned_to: user_id)

    Notification.create( user_id: user_id, 
                         actor_id: current_user_id,
                         verb: 'took task',
                         notification_type: 'project_task',
                         message: "Yay you can get started on task: #{task.title} for project: #{@project.title}", 
                         link: "/projects/#{project_id}/tasks#{task_id}",
                         isRead: false )

    javascript = "alert('You have successfully joined #{task_id}');"
    #PrivatePub.publish_to("/inbox/#{user_id}",javascript)
    redirect_to Project.find(project_id), notice: 'Request sent!'
  end

  def edit
    check_user_permission(params[:project_id])
    @user_to_projects = UserToProject.where(
      project_id: params[:project_id], 
      project_user_class: [ProjectUserClass::CORE_MEMBER, ProjectUserClass::OWNER] )
    @core_members = User.where(id: @user_to_projects.select(:user_id))
  end

  def show
    @has_project_permission = has_project_permission?(current_user_id, params[:project_id])
    @user_to_task = UserToTask.find_by_user_id_and_task_id(@task.assigned_to,@task.id)
    @statuses = ProjectTaskState::STATES
  end

  def update
    check_user_permission(params[:project_id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task.project, notice: 'Task updated!' }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    check_user_permission(params[:project_id])
    @task.destroy
    respond_to do |format|
      # change redirection
      format.html { redirect_to root_url, notice: 'Task was successfully destroyed.' }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(
        :title,
        :description,
        :created_by,
        :modified_at,
        :completed,
        :completed_on,
        :assign_to,
        :project_id,
        :workspace_id,
        :due_on
        )
    end

    def join_request_params
      params.permit(:user_id, :project_id, :task_id)
    end

    def accept_request_params
      params.permit(:user_id, :task_id, :link)
    end

    def check_user_permission(project_id)
      result = has_project_permission?(current_user_id, project_id)
      redirect_to root_url, notice: 'Not allowed' unless result
    end

end
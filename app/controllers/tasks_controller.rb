class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.where(project_id: params[:project_id])
  end

  def new
    check_user_permission(params[:project_id])
    @task = Task.new
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
        format.html { redirect_to @task.project }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    check_user_permission(params[:project_id])
    @user_to_projects = UserToProject.where(
      project_id: params[:project_id], 
      project_user_class: [ProjectUserClass::CORE_MEMBER, ProjectUserClass::OWNER] )
    @core_members = User.where(id: @user_to_projects.select(:user_id))
  end

  def show
  end

  def update
    check_user_permission(params[:project_id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task.project }
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
        :modified_by,
        :completed,
        :completed_on,
        :assign_to,
        :project_id,
        :workspace_id,
        :due_on
        )
    end

    def check_user_permission(project_id)
      result = has_project_permission?(current_user_id, project_id)
      redirect_to root_url, notice: 'Not allowed' unless result
    end

end
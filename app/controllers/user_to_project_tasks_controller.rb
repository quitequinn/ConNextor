class UserToProjectTasksController < ApplicationController
  before_action :set_user_to_project_task, only: [:show, :edit, :update, :destroy]

  # GET /user_to_project_tasks
  # GET /user_to_project_tasks.json
  def index
    @user_to_project_tasks = UserToProjectTask.all
  end

  # GET /user_to_project_tasks/1
  # GET /user_to_project_tasks/1.json
  def show
  end

  # GET /user_to_project_tasks/new
  def new
    @user_to_project_task = UserToProjectTask.new
  end

  # GET /user_to_project_tasks/1/edit
  def edit
  end

  # POST /user_to_project_tasks
  # POST /user_to_project_tasks.json
  def create
    @user_to_project_task = UserToProjectTask.new(user_to_project_task_params)

    respond_to do |format|
      if @user_to_project_task.save
        format.html { redirect_to @user_to_project_task, notice: 'User to project task was successfully created.' }
        format.json { render :show, status: :created, location: @user_to_project_task }
      else
        format.html { render :new }
        format.json { render json: @user_to_project_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_to_project_tasks/1
  # PATCH/PUT /user_to_project_tasks/1.json
  def update
    respond_to do |format|
      if @user_to_project_task.update(user_to_project_task_params)
        format.html { redirect_to @user_to_project_task, notice: 'User to project task was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_to_project_task }
      else
        format.html { render :edit }
        format.json { render json: @user_to_project_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_to_project_tasks/1
  # DELETE /user_to_project_tasks/1.json
  def destroy
    @user_to_project_task.destroy
    respond_to do |format|
      format.html { redirect_to user_to_project_tasks_url, notice: 'User to project task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # NOT USED.
  def check_permission
    @user_is_owner_of_association = has_user_permission? @user_to_project_task
    redirect_to root_url, notice: 'Wrong Permissions' unless @user_is_owner_of_association
    return false unless @user_is_owner_of_association
    true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_to_project_task
    @user_to_project_task = UserToProjectTask.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_to_project_task_params
    params.require(:user_to_project_task).permit(:user_id, :project_task_id, :relation)
  end
end

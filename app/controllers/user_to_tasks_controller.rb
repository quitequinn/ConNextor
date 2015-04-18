class UserToTasksController < ApplicationController
  before_action :set_user_to_task, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @user_to_task = UserToTask.new
    @user_to_task.status = 'N/A'
  end

  def create
    @user_to_task = UserToTask.new(user_to_task_params)
    @user_to_task.status = 'In Progress'
    respond_to do |format|
      if @user_to_task.save
        format.html { redirect_to @user_to_task.task.project }
      else
        format.html { render :new }
      end
    end
  end

  def feedback

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user_to_task.update(user_to_task_params)
        format.html { redirect_to @user_to_task.task.project }
      else
        format.html { render :edit }
        format.json { render json: @user_to_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @user_to_task.destroy
    respond_to do |format|
      # change redirection
      format.html { redirect_to root_url, notice: 'User to task was successfully destroyed.' }
    end
  end

  private
    def set_task
      @user_to_task = UserToTask.find(params[:id])
    end

    def user_to_task_params
      params.require(:user_to_task).permit(
        :user_id,
        :task_id,
        :rating,
        :status
        )
    end
end
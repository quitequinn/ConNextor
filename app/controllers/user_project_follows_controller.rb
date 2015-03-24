class UserProjectFollowsController < ApplicationController
  before_action :set_user_project_follow, only: [:show, :edit, :update, :destroy]

  # GET /user_project_follows
  # GET /user_project_follows.json
  def index
    @user_project_follows = UserProjectFollow.all
  end

  # GET /user_project_follows/1
  # GET /user_project_follows/1.json
  def show
  end

  # GET /user_project_follows/new
  def new
    @user_project_follow = UserProjectFollow.new
  end

  # GET /user_project_follows/1/edit
  def edit
  end

  # POST /user_project_follows
  # POST /user_project_follows.json
  def create
    user_id = current_user_id # might be nil
    project = Project.find(params[:project_id]) # might throw exception

    @user_project_follow = UserProjectFollow.new(user_id: user_id, project_id: project.id)

    respond_to do |format|
      if @user_project_follow.save
        format.html { redirect_to @user_project_follow.project, notice: 'You are now following this project.' }
        format.js
        format.json { render :show, status: :created, location: @user_project_follow }
      else
        format.html { render :new }
        format.json { render json: @user_project_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_project_follows/1
  # PATCH/PUT /user_project_follows/1.json
  def update
    respond_to do |format|
      if @user_project_follow.update(user_project_follow_params)
        format.html { redirect_to @user_project_follow, notice: 'User project follow was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_project_follow }
      else
        format.html { render :edit }
        format.json { render json: @user_project_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_project_follows/1
  # DELETE /user_project_follows/1.json
  def destroy
    @user_project_follow.destroy
    respond_to do |format|
      format.html { redirect_to project, notice: 'Project unfollowed' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_project_follow
      @user_project_follow = UserProjectFollow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_project_follow_params
      params.require(:user_project_follow).permit(:user_id, :project_id)
    end
end

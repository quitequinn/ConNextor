class UserFollowsController < ApplicationController
  before_action :set_user_follow, only: [:show, :edit, :update, :destroy]

  # GET /user_follows
  # GET /user_follows.json
  def index
    @user_follows = UserFollow.all
  end

  # GET /user_follows/1
  # GET /user_follows/1.json
  def show
  end

  # GET /user_follows/new
  def new
    @user_follow = UserFollow.new
  end

  # GET /user_follows/1/edit
  def edit
  end

  # POST /user_follows
  # POST /user_follows.json
  def create
    @user_follow = UserFollow.new(user_follow_params)

    respond_to do |format|
      if @user_follow.save
        format.html { redirect_to @user_follow, notice: 'User follow was successfully created.' }
        format.json { render :show, status: :created, location: @user_follow }
      else
        format.html { render :new }
        format.json { render json: @user_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_follows/1
  # PATCH/PUT /user_follows/1.json
  def update
    respond_to do |format|
      if @user_follow.update(user_follow_params)
        format.html { redirect_to @user_follow, notice: 'User follow was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_follow }
      else
        format.html { render :edit }
        format.json { render json: @user_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_follows/1
  # DELETE /user_follows/1.json
  def destroy
    @user_follow.destroy
    respond_to do |format|
      format.html { redirect_to user_follows_url, notice: 'User follow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_follow
      @user_follow = UserFollow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_follow_params
      params.require(:user_follow).permit(:follower_id, :followee_id)
    end
end

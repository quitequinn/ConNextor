class UserFollowsController < ApplicationController
  before_action :set_user_follow, only: [:show, :edit, :update, :destroy]

  def index
    @user_follows = UserFollow.all
  end

  def show
  end

  def new
    @user_follow = UserFollow.new
  end

  def edit
  end

  def create
    @user_follow = UserFollow.new(user_follow_params)

    respond_to do |format|
      if @user_follow.save
        format.html { redirect_to @user_follow, notice: 'User follow was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @user_follow }
      else
        format.html { render :new }
        format.json { render json: @user_follow.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @user_follow.destroy
    respond_to do |format|
      format.html { redirect_to user_follows_url, notice: 'User follow was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_user_follow
      @user_follow = UserFollow.find(params[:id])
    end

    def user_follow_params
      params.require(:user_follow).permit(:follower_id, :followee_id)
    end
end

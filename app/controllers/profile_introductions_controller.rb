class ProfileIntroductionsController < ApplicationController
  before_action :set_profile_introduction, only: [:show, :swap, :edit, :update, :destroy]

  def swap
    @user_is_owner_of_profile = has_profile_permission?(@profile_introduction)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def add
    @profile_introduction = ProfileIntroduction.new(profile_id: params[:profile_id])
    @user_is_owner_of_profile = has_profile_permission?(@profile_introduction)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    @profile_introduction = ProfileIntroduction.new(profile_introduction_params)
    @user_is_owner_of_profile = has_profile_permission?(@profile_introduction)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      if @profile_introduction.save
        format.html { redirect_to @profile_introduction, notice: 'Profile introduction was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @profile_introduction }
      else
        format.html { render :new }
        format.json { render json: @profile_introduction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_is_owner_of_profile = has_profile_permission?(@profile_introduction)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      if @profile_introduction.update(profile_introduction_params)
        format.html { redirect_to @profile_introduction, notice: 'Profile introduction was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @profile_introduction }
      else
        format.html { render :edit }
        format.json { render json: @profile_introduction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_profile_introduction
      @profile_introduction = ProfileIntroduction.find(params[:id])
    end

    def profile_introduction_params
      params.require(:profile_introduction).permit(:profile_id, :body)
    end
end

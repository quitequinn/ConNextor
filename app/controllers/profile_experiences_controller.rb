class ProfileExperiencesController < ApplicationController
  before_action :set_profile_experience, only: [:show, :swap, :edit, :update, :destroy]

  def swap
    @user_is_owner_of_profile = has_profile_permission?(@profile_experience)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def add
    @profile_experience = ProfileExperience.new(profile_id: params[:profile_id])
    @user_is_owner_of_profile = has_profile_permission?(@profile_experience)
    return unless @user_is_owner_of_profile
    respond_to do |format|
        format.js
    end
  end

  def create
    @profile_experience = ProfileExperience.new(profile_experience_params)
    @user_is_owner_of_profile = has_profile_permission?(@profile_experience)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      if @profile_experience.save
        format.html { redirect_to @profile_experience, notice: 'Profile experience was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @profile_experience }
      else
        format.html { render :new }
        format.json { render json: @profile_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_is_owner_of_profile = has_profile_permission?(@profile_experience)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      if @profile_experience.update(profile_experience_params)
        format.html { redirect_to @profile_experience, notice: 'Profile experience was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @profile_experience }
      else
        format.html { render :edit }
        format.json { render json: @profile_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile_experience.destroy
    respond_to do |format|
      format.html { redirect_to profile_experiences_url, notice: 'Profile experience was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_profile_experience
      @profile_experience = ProfileExperience.find(params[:id])
    end

    def profile_experience_params
      params.require(:profile_experience).permit(:profile_id, :name, :position, :from_date, :to_date, :description)
    end
  end

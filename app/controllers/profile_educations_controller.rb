class ProfileEducationsController < ApplicationController
  before_action :set_profile_education, only: [:show, :swap, :edit, :update, :destroy]

  def swap
    @user_is_owner_of_profile = has_profile_permission?(@profile_education)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def add
    @profile_education = ProfileEducation.new(profile_id: params[:profile_id])
    @user_is_owner_of_profile = has_profile_permission?(@profile_education)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    @profile_education = ProfileEducation.new(profile_education_params)
    @user_is_owner_of_profile = has_profile_permission?(@profile_education)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      if @profile_education.save
        format.html { redirect_to @profile_education, notice: 'Profile education was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @profile_education }
      else
        format.html { render :new }
        format.json { render json: @profile_education.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_is_owner_of_profile = has_profile_permission?(@profile_education)
    return unless @user_is_owner_of_profile
    respond_to do |format|
      if @profile_education.update(profile_education_params)
        format.html { redirect_to @profile_education, notice: 'Profile experience was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @profile_education }
      else
        format.html { render :edit }
        format.json { render json: @profile_education.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile_education.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_profile_education
      @profile_education = ProfileEducation.find(params[:id])
    end

    def profile_education_params
      params.require(:profile_education).permit(:profile_id, :school, :major, :from_date, :to_date, :description)
    end
end

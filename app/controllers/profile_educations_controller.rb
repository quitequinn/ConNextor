class ProfileEducationsController < ApplicationController
  before_action :set_profile_education, only: [:show, :swap, :edit, :update, :destroy]

  def swap
    return unless check_permission
    respond_to do |format|
      format.js
    end
  end

  def add
    @profile_education = ProfileEducation.new(profile_id: params[:profile_id])
    return unless check_permission
    respond_to do |format|
      format.js
    end
  end

  def create
    @profile_education = ProfileEducation.new(profile_education_params)
    return unless check_permission
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
    return unless check_permission
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

  # def destroy
  #   @profile_education.destroy
  #   respond_to do |format|
  #     format.html { redirect_to profile_educations_url, notice: 'Profile education was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  def check_permission
    @user_is_owner_of_profile = has_profile_permission? @profile_education
    redirect_to root_url, notice: 'Wrong Permissions' unless @user_is_owner_of_profile
    return false unless @user_is_owner_of_profile
    true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_profile_education
    @profile_education = ProfileEducation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_education_params
    params.require(:profile_education).permit(:profile_id, :school, :major, :from_date, :to_date, :description)
  end
end

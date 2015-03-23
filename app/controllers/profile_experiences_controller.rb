class ProfileExperiencesController < ApplicationController
  before_action :set_profile_experience, only: [:show, :swap, :edit, :update, :destroy]

  # # GET /profile_experiences
  # # GET /profile_experiences.json
  # def index
  #   @profile_experiences = ProfileExperience.all
  # end
  #
  # # GET /profile_experiences/1
  # # GET /profile_experiences/1.json
  # def show
  # end
  #
  # # GET /profile_experiences/new
  # def new
  #   @profile_experience = ProfileExperience.new
  # end
  #
  # # GET /profile_experiences/1/edit
  # def edit
  # end

  # AJAX purposes only.
  # GET /profile_experience/swap/1
  def swap
    return unless check_permission
    respond_to do |format|
      format.js
    end
  end

  # GET /profile_experience/add/:profile_id
  def add
    @profile_experience = ProfileExperience.new(profile_id: params[:profile_id])
    return unless check_permission
    respond_to do |format|
      format.js
    end
  end

  # POST /profile_experiences
  # POST /profile_experiences.json
  def create
    @profile_experience = ProfileExperience.new(profile_experience_params)
    return unless check_permission
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

  # PATCH/PUT /profile_experiences/1
  # PATCH/PUT /profile_experiences/1.json
  def update
    return unless check_permission
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

  # # DELETE /profile_experiences/1
  # # DELETE /profile_experiences/1.json
  # def destroy
  #   @profile_experience.destroy
  #   respond_to do |format|
  #     format.html { redirect_to profile_experiences_url, notice: 'Profile experience was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  def check_permission
    @user_is_owner_of_profile = has_profile_permission? @profile_experience
    redirect_to root_url, notice: 'Wrong Permissions' unless @user_is_owner_of_profile
    return false unless @user_is_owner_of_profile
    true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_profile_experience
    @profile_experience = ProfileExperience.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_experience_params
    params.require(:profile_experience).permit(:profile_id, :name, :position, :from_date, :to_date, :description)
  end
end

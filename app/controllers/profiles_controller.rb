class ProfilesController < ApplicationController
  # sets @profile
  before_action :set_profile, only: [:show, :update, :update_header, :destroy, :switch, :edit_bio, :edit_location, :edit_photo, :edit_cover]
  
  # sets @user_is_owner_of_profile
  before_action :set_profile_owner, only: [:show, :update, :update_header]
  
  def switch
    @tab_name = params[:tab]
    @tab_name.downcase!
    respond_to do |format|
      format.js
    end
  end

  def edit_photo
    respond_to do |format|
      format.js
    end
  end

  def edit_cover
    respond_to do |format|
      format.js
    end
  end

  def edit_bio
    respond_to do |format|
      format.js
    end
  end

  def edit_location
    respond_to do |format|
      format.js
    end
  end

  def stay_tuned
  end

  # Not the usual 'new', more like initialize.
  def new
    @user = current_user
    session[:step] = 0
  end

  # Create profile
  # First step
  def create
    @profile = Profile.new
    current_user.profile = @profile if current_user.profile == nil
    current_user.save
  
    respond_to do |format|
      if current_user.update_name user_params[:first_name], user_params[:last_name]
        session[:step] += 1        
        format.js { render 'update_registration.js.erb' }
      else
        format.html { render :new }
        format.js { render js: 'alert("internal error")' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # Profile building steps
  def update
    check_is_owner( current_user, @profile )
    session[:step] = 1 if session[:step] > 4
    if session[:step] == 2
      @profile.user.create_interests user_params[:interest_ids]
    end
    if session[:step] == 1
      @profile.update profile_params
    end
    respond_to do |format|
      session[:step] += 1
      if session[:step] == 2 || session[:step] == 3
        set_skills_and_interests
      end

      format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
      format.js { render 'update_registration.js.erb' }
    end
  end

  def update_header
    check_is_owner( current_user, @profile )
    respond_to do |format|
      if @profile.update profile_params
        format.js
      else
        format.js { render js: 'alert("internal error")' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private
    def set_profile
      # TODO more security?
      if params[:id]
        @profile = Profile.find(params[:id])
      elsif params[:username]
        @profile = User.find_by_username(params[:username]).profile
      elsif logged_in?
        @profile = current_user.profile
      else
        # not found
      end
    end

    def set_profile_owner
      if current_user and @profile
        @user_is_owner_of_profile = @profile == current_user.profile
      end
    end

    def profile_params
      params.require(:profile).permit(
        :profile_photo,
        :cover_photo,
        :resume,
        :location,
        :school,
        :short_bio
      )
    end

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :interest_ids=>[]
      )
    end

    def set_skills_and_interests
      @skills = Skill.all
      @interests = Interest.all
    end

    def check_is_owner( user, profile )
      unless user.profile == profile
        redirect_to current_user.profile, notice: 'No access'
      end
    end
end

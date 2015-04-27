class ProfilesController < ApplicationController
  # sets @profile
  before_action :set_profile, only: [:show, :new, :update, :destroy, :switch, :edit_bio, :edit_location, :edit_photo, :edit_cover, :additional_info, :register_info, :resume_info]
  
  # sets @user_is_owner_of_profile
  before_action :set_profile_owner, only: [:show, :update]
  
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

  # POST
  # main registration page
  def register_info
    respond_to do |format|
      if @profile.update profile_params
        # Profile.update_misc_info( current_user, profile_params )
        Profile.update_user_info( current_user, profile_params )
        @profile.user.create_interests( user_params[:interest_ids] )
        #@profile.user.create_skills( user_params[:skill_ids] )
        format.html { redirect_to controller: 'profiles', action: 'additional_info', id: @profile.id }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST
  # resume registration page
  def resume_info
    if profile_params[:resume] == nil
      flash[:warning] = 'Oops! You forgot to upload your resume or connect with linkedin'
      redirect_to controller: 'profiles', action: 'additional_info', id: @profile.id 
    else
      @profile.update profile_params
      redirect_to @profile
    end
  end

  # resume registration page
  def additional_info
  end

  # Not the usual 'new', more like initialize.
  # we created profile when we created user
  def new
    set_skills_and_interests
    if @profile.user
      if @profile.user.first_name
        @profile.first_name = @profile.user.first_name
      end
      if @profile.user.last_name
        @profile.last_name = @profile.user.last_name
      end
    end
  end

  def update
    check_is_owner( current_user, @profile )

    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
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
        :short_bio, 
        # :code,
        # :has_idea,
        :first_name, 
        :last_name )
    end

    def user_params
      params.permit(
          #:skill_ids=>[],
          :interest_ids=>[]
      )
    end

    def set_skills_and_interests
      @skills = Skill.all
      @interests = Interest.all
    end

    def check_is_owner( user, profile )
      unless user.profile == profile
        redirect_to current_user.profile, notice: 'permissions not right'
      end
    end
end

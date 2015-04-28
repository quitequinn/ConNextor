class ProfilesController < ApplicationController
  # sets @profile
  before_action :set_profile, only: [:show, :new, :update, :destroy, :switch, :edit_bio, :edit_location, :edit_photo, :edit_cover, :additional_info]
  
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

  # Not the usual 'new', more like initialize.
  # we created profile when we created user
  def new
    session[:step] = 0
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
    if session[:step] == 0
      @profile.user.update_name user_params[:first_name], user_params[:last_name]
    elsif session[:step] == 2
      @profile.user.create_interests user_params[:interest_ids]
    end
    respond_to do |format|
      if @profile.update profile_params
        session[:step] += 1
        if session[:step] == 2 || session[:step] == 3
          set_skills_and_interests
        end

        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.js { render 'update_registration.js.erb' }
      else
        format.html { render :new }
        format.js { render js: 'alert("internal error")' }
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
        redirect_to current_user.profile, notice: 'permissions not right'
      end
    end
end

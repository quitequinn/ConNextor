class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :new, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
    if current_user and @profile
      @user_is_owner_of_profile = @profile == current_user.profile
    end
  end

  # Not the usual 'new', more like initialize.
  # we created profile when we created user
  def new
    set_skills_and_interests
    if current_user and @profile
      @user_is_owner_of_profile = @profile == current_user.profile
    end
  end

  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save

        if profile_params
          if profile_params[:code]
            InvitationCode.create(user_id:current_user_id, used:false, code: profile_params[:code])
          end
          if profile_params[:has_idea] == 1
            ProfileIdea.create(user_id:current_user_id)
          end
        end

        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    unless current_user.profile == @profile
      redirect_to current_user.profile, notice: 'permissions not right'
    end

    if profile_params
      if profile_params[:code]
        if InvitationCode.find_by_user_id(current_user_id)
          InvitationCode.update(code: profile_params[:code])
        else
          InvitationCode.create(user_id:current_user_id, used:false, code: profile_params[:code])
        end
      end
      if profile_params[:has_idea] == 1
        if ProfileIdea.find_by_user_id(current_user_id) == nil
          ProfileIdea.create(user_id:current_user_id)
        end
      end
    end

    respond_to do |format|
      if @profile.update profile_params
        @profile.user.create_skills user_params[:skill_ids]
        @profile.user.create_interests user_params[:interest_ids]
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        set_skills_and_interests
        logger.error 'IF STATEMENT FAILED'
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
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

    def profile_params
      params.require(:profile).permit(:location, :school, :short_bio, :code, :has_idea)
    end

    def user_params
      params.permit(
          :skill_ids=>[],
          :interest_ids=>[]
      )
    end

    def set_skills_and_interests
      @skills = Skill.all
      @interests = Interest.all
    end
end

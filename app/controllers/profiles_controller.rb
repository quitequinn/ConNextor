class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :new, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @user_is_owner_of_profile = @profile == current_user.profile
  end

  # GET /profiles/new
  # Not the usual 'new', more like initialize.
  # we created profile when we created user
  def new
    set_skills_and_interests
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    unless current_user.profile == @profile
      redirect_to @user, notice: 'permissions not right'
    end

    respond_to do |format|
      # a = @profile.update profile_params
      # b = @profile.user.create_skills user_params[:skill_ids]
      # logger.error "profile update: #{a}"
      # logger.error "skill/interest update: #{b}"
      # logger.error "skill/interest update: #{}"
      # logger.error "#{b}"
      # b = @profile.user.update user_params
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

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(
        # :user_id,
        :location,
        :school,
        :short_bio,
    )

  end

  def user_params
    params.require(:user).permit(
        :skill_ids=>[],
        :interest_ids=>[]
    )
  end

  def set_skills_and_interests
    @skills = Skill.all
    @interests = Interest.all
  end
end

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]

  def new
    session[:user_params] ||= {}
    @user = User.new
  end

  # def create
  #   session[:user_params].deep_merge!(user_params) if user_params
  #   @user = User.new(session[:user_params])
  #   @user.current_step = session[:reg_step]
  #   @skills = Skill.all
  #   @interests = Interest.all
  #
  #   if params[:back_button]
  #     @user.previous_step
  #   elsif @user.last_step?
  #     if @user.save
  #       if session[:identity_id]
  #         identity = Identity.find(session[:identity_id])
  #         identity.user = @user
  #         identity.save()
  #         session[:identity_id] = nil
  #       end
  #       flash[:success] = "Signed up!"
  #       session[:reg_step] = session[:user_params] = nil
  #       redirect_to root_url and return
  #     else
  #       render 'new' and return
  #     end
  #   else
  #     @user.next_step
  #   end
  #   session[:reg_step] = @user.current_step
  #   render 'new'
  #
  #
  #
  # end

  # POST users/
  # POST users.json
  def create
    @user = User.new(user_params)
    # TODO for security, use a 128 bit hash instead of id when marshalling
    identity_id = params.require(:user)[:identity_id]
    profile_id = params.require(:user)[:profile_id]

    registering_with_omni_auth = identity_id and profile_id

    if registering_with_omni_auth
      @identity = Identity.find(identity_id)
      @user.profile = Profile.find(profile_id)
    end

    @user.password_login = true unless registering_with_omni_auth

    respond_to do |format|
      if @user.save
        if registering_with_omni_auth
          @identity.user = @user
          @identity.save
        else
          @profile = Profile.new
          @profile.save # no reason for it not to save
          @user.profile = @profile
          @user.save # no room for errors
        end

        # Confirm Email here, don't login.
        sign_in @user

        format.html { redirect_to controller: :profiles, action: :new, id: @user.profile_id}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @allusers = User.search(params[:search]).paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to @user, notice: 'permissions not right'
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @user_is_owner_of_user = @user == current_user
  end


  private
  def user_params
    params.require(:user).permit(
        :username,
        :email,
        :first_name,
        :last_name,
        # :school,
        # :school_email,
        # :location,
        # :industry,
        # :skill_ids=>[],
        # :interest_ids=>[],
        :password,
        :password_confirmation)
  end


  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to log_in_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end

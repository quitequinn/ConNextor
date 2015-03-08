class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]  
  before_action :correct_user,   only: [:edit, :update]

  def new
    session[:user_params] ||= {}
    @user = User.new
  end

  def create
    session[:user_params].deep_merge!(user_params) if user_params
    @user = User.new(session[:user_params])
    @user.current_step = session[:reg_step]
    if params[:back_button]
      @user.previous_step
    elsif @user.last_step?
      if @user.save
        session[:reg_step] = session[:user_params] = nil
        if session[:identity_id]
          identity = Identity.find(session[:identity_id])
          identity.user = @user
          identity.save()
          session[:identity_id] = nil
        end
        flash[:success] = "Signed up!"
        redirect_to root_url and return
      else
        render 'new' and return
      end
    else
      @user.next_step
    end
    session[:reg_step] = @user.current_step
    render 'new'

  end

  def index
    @allusers = User.search(params[:search]).paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :school,:school_email,:location,:industry, :email, :password, :password_confirmation)
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

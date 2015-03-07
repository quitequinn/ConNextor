class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]  
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if session[:identity_id]
        identity = Identity.find(session[:identity_id])
        identity.user = @user
        identity.save()
        session[:identity_id] = nil
      end
      @user.send_email_confirmation
      flash[:success] = "Signed up! Check your email for verification"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @allusers = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def confirmed(id, code)
    user = User.find(id)
    if user
      if code == user.confirm_code
        user.confirmed = true
        user.save()
        session_create user
        flash[:success] = "You have been verified!"
      end
    end
    redirect_to root_url
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
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
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

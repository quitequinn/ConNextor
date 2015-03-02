class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]  
  before_action :correct_user,   only: [:edit, :update]

  def new
    if current_user
      @user = current_user
    else
      @user = User.new
    end
  end

  def create
    if current_user
      if current_user.update_attributes(user_params)
        flash[:success] = "Profile sucessfully created!!"
        redirect_to root_url
      else
        render 'new'
      end
    else
      @user = User.new(user_params)
      if @user.password.present?
        if @user.save
          flash[:success] = "Signed up!"
          redirect_to root_url
        else
          render 'new'
        end
      else
        flash[:success] = "Need to enter password"
        render 'new'
      end
    end
  end

  def newAdditionalInfo
    @user = User.find(params[:id])
  end

  def index
    @allusers = User.paginate(page: params[:page])
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

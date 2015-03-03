class SessionsController < ApplicationController
  before_action :check_signed_in, except: :destroy

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      if params[:remember_me]
        flash.now.alert = "Remember me!"
        sign_in user
      else
        session_create user
      end
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:success] = "Invalid login"
      render "new"
    end
  end

  def omniauthcreate
    @auth = env['omniauth.auth']
    @identity = Identity.find_with_omniauth(@auth)
    @identity = Identity.create_with_omniauth(@auth) if @identity.nil?

    if logged_in?
      if @identity.user == current_user
        # Identity is already associated with this user
        redirect_to root_url, notice: "Already logged in with omniauth"
      else
        # Identity is not associated with the current_user
        @old_user = @identity.user
        if @old_user
          #current_user.posts << @old_user.posts
          #current_user.galleries << @old_user.galleries
          #current_user.favorites << @old_user.favorites
        end
        @identity.user = current_user
        @identity.save()
        @old_user.destroy if @old_user && @old_user.identities.blank?
        redirect_to root_url, notice: "Account was successfully linked"
      end
    else
      if @identity.user
        # Identity has a user associated with it
        session_create @identity.user
        redirect_to root_url
      else
        # No user associated with the identity so create a new one
        # If user has registered and then logins with fb
        user = User.find_by_email(@auth.info.email)
        if user
          session_create user
          @identity.user = user
          @identity.save()
          redirect_to root_url, notice: "Successful login!"
          #end
        else # if user logs in with provider but is not registered
          #user = User.create_with_omniauth(auth)
          #session_create user
          #@identity.user = user
          #@identity.save()
          redirect_to additional_info_path, notice: "Sorry you need to register for an account"
        end
        
      end
    end
  end

  def newAdditionalInfo
    @user=User.new
  end

  def createAdditionalInfo
    @user = User.new(user_params)
    @user = @user.update_with_omniauth(@auth)
    session_create @user
    if @identity
      @identity.user = @user
      @identity.save()
    end

    if @user.save
      flash[:success] = "Successful sign up!"
      redirect_to root_url
    else
      render 'newAdditionalInfo'
    end
  end

  def destroy
    sign_out
    session_destroy
    flash[:success] = "Signed out successfully!"
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end

    def check_signed_in
      if logged_in?
        flash.now.alert = "Already signed in"
        redirect_to rool_url
      end
    end

  #def user_params
    #params.require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at)
  #end
end

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
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def omniauthcreate
    user = User.omniauth(env['omniauth.auth'])
    session_create user
    redirect_to root_url
  end

  def destroy
    sign_out
    session_destroy
    redirect_to root_url, :notice => "Signed out successfully!"
  end

  private
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

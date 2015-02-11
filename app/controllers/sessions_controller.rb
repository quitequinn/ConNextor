class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      log_in user
      redirect_to root_url
    else
      flash[:success] = "Invalid login"
      render "new"
    end
  end

  def omniauthcreate
    user = User.omniauth(env['omniauth.auth'])
    log_in user
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at)
  end
end

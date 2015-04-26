class SessionsController < ApplicationController
  #before_action :check_signed_in, except: :destroy

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session_create user
      if user.profile == nil
        format.html { redirect_to controller: :profiles, action: :new, :notice => 'Must complete profile!' }
      else
        flash[:success] = 'Logged in!'
        redirect_to root_url
      end     
    else
      flash[:error] = 'Invalid login'
      render 'new'
    end
  end

  def omniauthcreate
    auth = env['omniauth.auth']
    @identity = Identity.find_with_omniauth(auth) || Identity.create_with_omniauth(auth)

    if logged_in?
      if @identity.user == current_user
        # Identity is already associated with this user
        redirect_to profile_path(current_user.profile), notice: "Already logged in with omniauth"
      else
        # Identity is not associated with the current_user
        @identity.user = current_user
        @identity.save
        redirect_to profile_path(current_user.profile), notice: "Account was successfully linked"
      end
    else
      if @identity.user
        # Identity has a user associated with it, we simply log them in
        session_create @identity.user
        redirect_to root_url
      else
        # No user associated with the identity so create a new one
        # If user has registered and then logs in with provider
        # if user logs in with provider but is not registered

        @user = User.find_by_email(auth.info.email) || User.new
        @user.update_with_omniauth(auth)
        if @user.save
          session_create @user
          @identity.user = @user
          @identity.save
          @user.profile.user = @user
          @user.profile.save

          respond_to do |format|
            format.html { redirect_to controller: :profiles, action: :new, id: @user.profile_id }
            format.js
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        else
          # Email or username is missing or invalid

          # Save identity first without user
          @identity.save
          respond_to do |format|
            format.html { render 'users/new', notice: 'Need additional info.' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  def destroy
    sign_out
    session_destroy
    flash[:success] = "Signed out successfully!"
    redirect_to root_url
  end

  #private
    # def check_signed_in
    #   if logged_in?
    #     flash.now.alert = "Already signed in"
    #     redirect_to root_url
    #   end
    # end
end

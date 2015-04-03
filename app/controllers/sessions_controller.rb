class SessionsController < ApplicationController
  before_action :check_signed_in, except: :destroy

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session_create user     
      redirect_to root_url, :notice => 'Logged in!'
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
        @old_user = @identity.user
        if @old_user
          #current_user.posts << @old_user.posts
          #current_user.galleries << @old_user.galleries
          #current_user.favorites << @old_user.favorites
        end
        @identity.user = current_user
        @identity.save
        @old_user.destroy if @old_user && @old_user.identities.blank?
        redirect_to root_url, notice: "Account was successfully linked"
      end
    else
      if @identity.user
        # Identity has a user associated with it, we simply log them in
        # if auth.provider == "twitter" # && @identity.user.location == nil #????
        #   @identity.user.update_with_omniauth(auth)
        # end
        session_create @identity.user
        redirect_to root_url
      else
        # No user associated with the identity so create a new one
        # If user has registered and then logs in with provider
        # if user logs in with provider but is not registered

        # I believe this actually takes care of both cases - 20150315
        @user = User.find_by_email(auth.info.email) || User.new
        @user.update_with_omniauth(auth)
        if @user.save
          # all fields are a-okay
          session_create @user
          @identity.user = @user
          @identity.save # shouldn't have errors
          @user.profile.user = @user
          @user.profile.save

          redirect_to root_url, notice: "Successful login!"
        else
          # Email or username is missing or invalid

          # Save identity first without user
          @identity.save

          # session[:identity_id] = @identity.id
          # redirect_to new_user_path, notice: 'Sorry you need to first register for an account'

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

  private
    def check_signed_in
      if logged_in?
        flash.now.alert = "Already signed in"
        redirect_to rool_url
      end
    end
end

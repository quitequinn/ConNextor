module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:remember_token)
  end

  def session_create(user)
    session[:user_id] = user.id
  end

  def session_destroy
    session[:user_id] = nil
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:remember_token]
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
  end

  def current_user_id
    session[:user_id]
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)  #This evaluates to session[:forwarding_url] unless it’s nil, in which case it evaluates to the given default URL.
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end

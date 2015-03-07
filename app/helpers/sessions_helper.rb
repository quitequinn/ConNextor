module SessionsHelper

  def session_create(user)
    session[:user_id] = user.id
  end

  def session_destroy
    session[:user_id] = nil
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

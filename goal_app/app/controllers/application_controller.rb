class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def require_log_in
    redirect_to new_session_url unless logged_in?
  end

  def login(user)
    session[:session_token] = user.reset_token!
    @current_user = user
  end

  def logged_in?
    !!current_user
  end

  def log_out
    @current_user.reset_token! if logged_in?
    session[:session_token] = nil
    @current_user = nil
  end

end

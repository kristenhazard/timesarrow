# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  local_addresses.clear
  
  before_filter :find_genres_by_subcat
  
  helper :all # include all helpers, all the time
  helper_method :admin?, :current_user, :current_user_session, :logged_in?
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  def find_genres_by_subcat
    @genres = Timeline.genre_distinct_by_subcat
  end
  
  protected
  
  def admin?
    if current_user
     current_user.username == "kristen"
   end
  end
  
  def require_admin
    unless admin?
      flash[:error] = "Unauthorized access"
      redirect_to home_path
      false
    end
  end
  
  def logged_in?
    if current_user
      current_user
    end
  end
  
  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to home_path
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  
end

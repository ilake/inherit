# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_location, :user_hometown
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_inviter
  before_filter :ip_location

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  private
  def app_helpers
    @app_helpers ||= ApplicationController.helpers
  end
  
  def user_selected
    @user ||= User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
    unless @user
      flash[:error] = 'Please login first'
      redirect_to new_user_session_path
    end
    return @user
  end

  def current_user_location
    session[:current_location] = params[:location] if params[:location]
    session[:current_location] ||= user_hometown
    session[:current_location] ||= ip_location
  end

  def user_hometown
    session[:hometown] ||= current_user.try(:location_list).try(:to_s)
  end

  def ip_location
    client_ip = (RAILS_ENV == 'development') ? '60.251.181.109' : request.remote_ip
    session[:ip_location] ||= LocalizedCountrySelect::localized_countries_hash.fetch(IP_COUNTRY.country(client_ip)[3])
  end

  def force_set_profile
    redirect_to edit_user_profile_path(current_user) if current_user && current_user.try(:birthday).blank?
  end

  def authenticate_inviter
    authenticate_or_request_with_http_basic do |name, password|
      name == 'i' && password == 'lovetaiwan'
    end
    warden.custom_failure! if performed? 
  end
end

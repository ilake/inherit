# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_location, :user_hometown, :current_data_number
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
    #一直有一個timeline action 沒找到, 先用這樣擋掉
    render :nothing => true and return if params.has_key?("0")

    @user ||= User.find(:first, :conditions => {:username => params[:username]}) if params[:username]
    @user ||= User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
    unless @user
      flash[:error] = 'Please login first'
      redirect_to new_user_session_path
    end
    return @user
  end

  def current_data_number(data_number=nil)
    cookies[:current_data_number] = data_number.to_i if data_number
    cookies[:current_data_number] ||= 30
  end

  def current_user_location
    session[:current_location] = params[:location] if !params[:location].blank?
    session[:current_location] ||= user_hometown
  end

  def user_hometown
    session[:hometown] ||= current_user.try(:location_list).try(:to_s)
    session[:hometown] ||= ip_location
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

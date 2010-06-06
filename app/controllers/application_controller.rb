# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_location
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_inviter

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  private
  def user_selected
    @user ||= User.find(params[:user_id])
  end

  def current_user_location
    #session[:current_location] ||= current_user.try(:location_list).try(:to_s)
    current_user.try(:location_list).try(:to_s)
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

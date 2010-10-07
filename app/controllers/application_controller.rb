# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_location, :user_hometown, :current_data_number
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #before_filter :authenticate_inviter
  before_filter :ip_location
  before_filter :set_locale

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = I18n.t("can.not")
    redirect_to root_url
  end

  private
  def app_helpers
    @app_helpers ||= ApplicationController.helpers
  end
  
  def user_selected
    #一直有一個timeline action 沒找到, 先用這樣擋掉
    render :nothing => true and return if params.has_key?("0")

#    @user ||= User.find(:first, :conditions => {:username => params[:username]}) if params[:username]
#    @user ||= User.find(params[:user_id]) if params[:user_id]
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
    #預設是台灣的ip
    client_ip = (RAILS_ENV == 'development') ? '60.251.181.109' : request.remote_ip
    session[:ip_location] ||= LocalizedCountrySelect::localized_countries_hash.fetch(IP_COUNTRY.country(client_ip)[3].upcase)
  end

  def force_set_profile
    redirect_to edit_user_profile_path(current_user) if current_user && current_user.profile.invalid?
  end

#  def authenticate_inviter
#    authenticate_or_request_with_http_basic do |name, password|
#      name == 'i' && password == 'lovetaiwan'
#    end
#    warden.custom_failure! if performed? 
#  end

  def set_locale
    if !cookies[:locale]
      accept_lang = request.env['HTTP_ACCEPT_LANGUAGE']
      request_language = if accept_lang.try(:match, /(tw)/i)
                           'tw'
                         elsif accept_lang.try(:match, /(cn)/i)
                           'cn'
                         else
                           'en'
                         end                  
    end
    
    cookies[:locale] ||= LOCALES_AVAILABLE.include?(request_language) ? request_language : I18n.default_locale
    # if this is nil then I18n.default_locale will be used
    I18n.locale = cookies[:locale]
  end

  def exp_timeline_content(experiences)
    experiences.map{ |e|
      #Does not have end_at or start_at equal to end_at
      end_time_hash = e.end_at_hash
      {
      'start' => e.start_at.to_s(:date),
      'title' => app_helpers.truncate_u(Sanitize.clean(e.content), 10),
      'description' => "
      <span class='function'>
      #{app_helpers.link_to t('action.edit'), edit_experience_path(e) if can? :update, e}
      #{app_helpers.link_to t('action.destroy'), destroy_experience_path(e) if can? :destroy, e}
      #{app_helpers.link_to "<strong>#{t('exp.detail')}</strong>", experience_path(e)}
      </span>
      <br /> 
      #{app_helpers.truncate_u(Sanitize.clean(e.content), 100)}",
      'color' => e.color
      }.merge!(end_time_hash)
    }
  end

  def goal_timeline_content(goals, events)
     goals.each { |g|
       events << {
          'start' => g.start_at.to_s(:date),
          'title' => "[#{I18n.t('goal.label')}]#{g.title}",
          'description' => "
      <span class='function'>
          #{app_helpers.link_to t('action.edit'), edit_goal_path(g) if can? :update, g}
          #{app_helpers.link_to t('action.destroy'), destroy_goal_path(g) if can? :destroy, g}
          #{app_helpers.link_to "<strong>#{t('goal.detail')}</strong>", user_exps_path(g.user, g)}
      </span>
          <br /> 
          #{app_helpers.truncate_u(Sanitize.clean(g.content), 100)}",
          'color' => "##{rand(10)}#{rand(10)}#{rand(10)}"
       }
    }
    return events
  end

  def timeline_events(experiences, goals)
    events = exp_timeline_content(experiences)
    events = goal_timeline_content(goals, events)
    return events
  end
end

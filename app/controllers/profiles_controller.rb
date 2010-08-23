class ProfilesController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:show]

  def index
    @profiles = Profile.all
  end
  
  def show
    @profile = user_selected.profile
  end
  
  def edit
  end
  
  def update
    if current_user.update_attributes(params[:user])
      session[:hometown] = current_user.location_list.to_s
      session[:current_location] = user_hometown

      flash[:notice] = I18n.t("action.update_successfully")
      redirect_to user_profile_path(current_user)
    else
      flash[:error] = I18n.t("action.update_fail")
      render :action => 'edit'
    end
  end
end

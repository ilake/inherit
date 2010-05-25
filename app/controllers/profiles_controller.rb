class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:show]

  def index
    @profiles = Profile.all
  end
  
  def show
    @profile = user_selected.profile
  end
  
  def edit
    @profile = current_user.profile
  end
  
  def update
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      session[:current_location] = current_user.location_list.to_s

      flash[:notice] = "Successfully updated profile."
      redirect_to user_profile_path(current_user)
    else
      render :action => 'edit'
    end
  end
end

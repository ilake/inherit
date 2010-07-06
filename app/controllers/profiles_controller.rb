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
  end
  
  def update
    if current_user.update_attributes(params[:user])
      session[:hometown] = current_user.location_list.to_s

      flash[:notice] = "Successfully updated profile."
      redirect_to user_profile_path(current_user)
    else
      render :action => 'edit'
    end
  end
end

class HomeController < ApplicationController
  before_filter :user_auth, :only => [:index]

  def index
    @experiences = Experience.limit(5).descend_by_updated_at
    @exp_tags = Experience.tag_counts_on(:tags, :limit => 20)

    render :layout => 'homepage'
  end

  def user
    params[:location] ||= current_user.try(:location_list)
    @user_experiences = current_user.experiences.descend_by_updated_at.limit(5) 
    @latest_experiences = Experience.location_with(params[:location]).descend_by_updated_at.limit(5).all(:include => :user)
    @near_experience = Experience.tagged_with(current_user.owned_tags.map{|t| t.name}.rand).limit(1)[0]
  end

  private
  def user_auth
    redirect_to user_experiences_path(current_user) if user_signed_in?
  end
end

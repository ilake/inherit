class HomeController < ApplicationController
  before_filter :user_auth, :only => [:index]
  before_filter :force_set_profile

  def index
    @experiences = Experience.limit(5).descend_by_updated_at
    @exp_tags = Experience.tag_counts_on(:tags, :limit => 20)
    @user = User.new

    render :layout => 'homepage'
  end

  def user

    if user_signed_in?
      #params[:location] ||= current_user.try(:location_list)
      @user_experiences = current_user.experiences.descend_by_updated_at.limit(5) 
      @latest_experiences = Experience.location_with(current_user_location).descend_by_updated_at.limit(5).all(:include => :user)
      @near_experience = if current_user.owned_tags.blank?
                           Experience.tally({  :at_least => 1, 
                                            :at_most => 10000,  
                                            :start_at => 1.weeks.ago,
                                            :end_at => 1.day.ago,
                                            :limit => 1,
                                            :order => "items.name desc"
                           }).first

                         else
                           Experience.tagged_with(current_user.owned_tags.map{|t| t.name}.rand).limit(1).first
                         end
    else
      @latest_experiences = Experience.location_with(current_user_location).descend_by_updated_at.limit(5).all(:include => :user)
      @near_experience = Experience.last
    end
  end

  private
  def user_auth
    redirect_to user_experiences_path(current_user) if user_signed_in? 
  end
end

class HomeController < ApplicationController
  before_filter :user_auth, :only => [:index]
  before_filter :force_set_profile

  def index
    render :layout => 'homepage'
  end

  def user

    @experiences = Experience.location_with(current_user_location).descend_by_updated_at.limit(10).all
    @goals = Goal.location_with(current_user_location).descend_by_updated_at.limit(10).all


    exp_ids = @experiences.map{|e| e.id }
    @exp_tags = Experience.tag_counts_on(:tags, :limit => 20, :conditions => {:id => exp_ids})

    goal_ids = @goals.map{|g| g.id }
    @goal_tags = Goal.tag_counts_on(:tags, :limit => 20, :conditions => {:id => goal_ids})
  end

  private
  def user_auth
    redirect_to user_experiences_path(current_user) if user_signed_in? 
  end
end

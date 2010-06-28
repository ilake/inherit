class HomeController < ApplicationController
  before_filter :user_auth, :only => [:index]
  before_filter :force_set_profile

  caches_action :index


  def index
    render :layout => 'homepage'
  end

  def user
    @experiences = Handcache.compressed_get_and_set("explore_experiences", :expires_in => 60) do  
      Experience.location_with(current_user_location).descend_by_updated_at.limit(10).all
    end  

    @goals = Handcache.compressed_get_and_set("explore_goals", :expires_in => 60) do  
      Goal.location_with(current_user_location).descend_by_updated_at.limit(10).all
    end  

    @exp_tags = Handcache.compressed_get_and_set("explore_exp_tags", :expires_in => 60) do  
      exp_ids = @experiences.map{|e| e.id }
      Experience.tag_counts_on(:tags, :limit => 20, :conditions => {:id => exp_ids})
    end  

    @goal_tags = Handcache.compressed_get_and_set("explore_goal_tags", :expires_in => 60) do  
      goal_ids = @goals.map{|g| g.id }
      Goal.tag_counts_on(:tags, :limit => 20, :conditions => {:id => goal_ids})
    end  

  end

  private
  def user_auth
    redirect_to user_experiences_path(current_user) if user_signed_in? 
  end
end

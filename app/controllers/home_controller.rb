class HomeController < ApplicationController
  before_filter :user_auth, :only => [:index]
  before_filter :force_set_profile

  caches_action :index


  def index
    render :layout => 'homepage'
  end

  def user
    Experience
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

    #最多人追蹤的
    @popular_users = Profile.location_with(current_user_location).find(:all, :select => 'users.fans_count as user_fans_count, users.username as username', :joins => "left outer join users on profiles.user_id = users.id", :order => 'user_fans_count DESC', :limit => 5)
    @latest_users = Profile.location_with(current_user_location).find(:all, :select => 'users.username as username, profiles.created_at as created_at', :joins => "left outer join users on profiles.user_id = users.id", :order => 'created_at DESC', :limit => 5)
  end

  private
  def user_auth
    redirect_to user_home_path(current_user.username) if user_signed_in? 
  end
end

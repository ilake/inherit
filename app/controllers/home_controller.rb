class HomeController < ApplicationController
  before_filter :force_set_profile
  before_filter :user_auth, :only => [:index]

  def index
#    Goal
#    @working_goals = Handcache.compressed_get_and_set("explore_goals_#{current_user_location}_working", :expires_in => 60) do  
#      Goal.location_with(current_user_location).public.state_is('working').descend_by_updated_at.limit(5).all
#    end  
    #@events = goal_timeline_content(@working_goals, []).to_json
    render :layout => 'homepage'
  end

  def user
    Experience
    @experiences = Handcache.compressed_get_and_set("explore_experiences_#{current_user_location}", :expires_in => 60) do  
      Experience.location_with(current_user_location).public.descend_by_updated_at.limit(10).all
    end  

    @working_goals = Handcache.compressed_get_and_set("explore_goals_#{current_user_location}_working", :expires_in => 60) do  
      Goal.location_with(current_user_location).public.state_is('working').descend_by_updated_at.limit(10).all
    end  

    @help_goals = Handcache.compressed_get_and_set("explore_goals_#{current_user_location}_help", :expires_in => 60) do  
      Goal.location_with(current_user_location).public.state_is('help').descend_by_updated_at.limit(10).all
    end  

    @finish_goals = Handcache.compressed_get_and_set("explore_goals_#{current_user_location}_finish", :expires_in => 60) do  
      Goal.location_with(current_user_location).public.state_is('finish').descend_by_updated_at.limit(10).all
    end  

    @exp_tags = Handcache.compressed_get_and_set("explore_exp_tags", :expires_in => 60) do  
      exp_ids = @experiences.map{|e| e.id }
      Experience.tag_counts_on(:tags, :limit => 20, :conditions => {:id => exp_ids})
    end  

    @goal_tags = Handcache.compressed_get_and_set("explore_goal_tags", :expires_in => 60) do  
      goal_ids = @working_goals.map{|g| g.id }
      Goal.tag_counts_on(:tags, :limit => 20, :conditions => {:id => goal_ids})
    end  

    #最多人追蹤的
    @popular_profiles = Profile.location_with(current_user_location).find(:all, :select => 'users.fans_count as user_fans_count, profiles.user_id as user_id', :joins => "left outer join users on profiles.user_id = users.id", :order => 'user_fans_count DESC', :limit => 5, :conditions => "users.fans_count <> 0")
    @latest_profiles = Profile.location_with(current_user_location).find(:all, :select => 'profiles.created_at as created_at, profiles.user_id as user_id', :joins => "left outer join users on profiles.user_id = users.id", :order => 'created_at DESC', :limit => 5)
  end

  def user_location
    render :layout => false
  end

  def change_user_location
    session[:current_location] = params[:user_location]
    render :nothing => true
  end

  private
  def user_auth
    redirect_to user_home_path(current_user.username) if user_signed_in? 
  end
end

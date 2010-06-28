class SearchController < ApplicationController
  def index
    #@profiles = Profile.search params[:search], :include => :user
    @goals = Goal.search params[:search], :limit => 3
    @experiences = Experience.search params[:search], :limit => 10
  end

  def experiences
    @experiences = Experience.search params[:search], :page => params[:page], :per_page => 15
    render :action => 'index'
  end

  def goals
    @goals = Goal.search params[:search], :page => params[:page], :per_page => 15
    render :action => 'index'
  end
end

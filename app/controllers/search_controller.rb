class SearchController < ApplicationController
  def index
    #@questions = Question.search params[:search], :limit => 3
    @profiles = Profile.search params[:search], :include => :user, :limit => 3
    @goals = Goal.search params[:search], :limit => 3
    @experiences = Experience.search params[:search], :limit => 5
  end

  def experiences
    @experiences = Experience.search params[:search], :page => params[:page], :per_page => 15
    render :action => 'index'
  end

  def goals
    @goals = Goal.search params[:search], :page => params[:page], :per_page => 15
    render :action => 'index'
  end

  def users
    @profiles = Profile.search params[:search], :include => :user, :page => params[:page], :per_page => 15
    render :action => 'index'
  end

  def random
    #隨機挑個tag出來, 用它的name做search 
    @tag = Tag.find(:first, :offset => (rand Tag.count).to_i)
    tag_name = @tag ? @tag.name : 'iosel'
    @profiles = Profile.search tag_name, :limit => 3
    @goals = Goal.search tag_name, :limit => 3
    @experiences = Experience.search tag_name, :limit => 5
    
    render :action => 'index'
  end
end

class SearchController < ApplicationController
  def index
    #@profiles = Profile.search params[:search], :include => :user
    @questions = Question.search params[:search], :limit => 3
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

  def questions
    @questions = Question.search params[:search], :page => params[:page], :per_page => 15
    render :action => 'index'
  end
end

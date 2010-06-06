class SearchController < ApplicationController
  def index
    @profiles = Profile.search params[:search], :include => :user
    @experiences = Experience.search params[:search]
  end
end

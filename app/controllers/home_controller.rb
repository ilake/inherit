class HomeController < ApplicationController
  def index
    @users = User.all
    @exp_tags = Experience.tag_counts_on(:tags)
    @goal_tags = Goal.tag_counts_on(:tags)
  end
end

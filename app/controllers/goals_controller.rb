class GoalsController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:index]
  def index
    @goals = user_selected.goals.all
  end
  
  def show
    @goal = Goal.find(params[:id], :include => [:experiences])
    @comments = @goal.comments.recent.find(:all, :include => :user)
    @comment = @goal.comments.new
  end
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = current_user.goals.new(params[:goal])
    if @goal.save
      flash[:notice] = "Successfully created goal."
      redirect_to user_home_path(current_user.username) 
    else
      render :action => 'new'
    end
  end
  
  def edit
    @goal = current_user.goals.find(params[:id])
  end
  
  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update_attributes(params[:goal])
      flash[:notice] = "Successfully updated goal."
      redirect_to @goal
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    flash[:notice] = "Successfully destroyed goal."
    redirect_to user_home_path(current_user.username) 
  end
end

class GoalsController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:index]
  load_and_authorize_resource :nested => :user

  def index
    @goals = user_selected.goals.all
  end
  
  def show
    @goal = Goal.find(params[:id])
    @comments = @goal.comments.recent.find(:all, :include => :user)
    @comment = @goal.comments.new
  end
  
  def new
    @goal = Goal.new(params[:goal])
    render :layout => false if params[:rel]
  end
  
  def create
    @goal = current_user.goals.new(params[:goal])
    if @goal.save
      flash[:notice] = "Successfully created goal."
      respond_to do |format|
        format.html {redirect_to user_home_path(current_user.username)}
        format.js { 
          render :inline => "<%= select :experience, :goal_id, current_user.goals.map{|g|[g.title, g.id]}, {:include_blank => true}%>"
        }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.js { render :nothing => true } 
      end
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

class GoalsController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  load_and_authorize_resource :nested => :user

  def index
    state = ['working', 'help', 'finish'].include?(params[:state]) ? params[:state] : 'working' 
    @goals = Goal.location_with(current_user_location).public.state_is(state).descend_by_updated_at.paginate :page => params[:page], :per_page => 10
  end
  
  def show
    @goal = Goal.find(params[:id])
    @experiences = @goal.user.experiences.show_policy(@goal.user.is_owner?(current_user)).goal_categroy(@goal.id).descend_by_position.limit(3)
    @comments = @goal.comments.recent.find(:all, :include => :user)
    @comment = @goal.comments.new
    @related_goals = @goal.find_related_goals(current_user_location)
  end
  
  def new
    @goal = Goal.new(params[:goal])
    render :layout => false if params[:rel]
  end
  
  def create
    @goal = current_user.goals.new(params[:goal])
    if @goal.save
      flash[:notice] = I18n.t("action.create_successfully")
      respond_to do |format|
        format.html {redirect_to user_home_path(current_user.username)}
        format.js { 
          render :json => {'SUCCESS' => "#{ActionController::Base.helpers.select :experience, :goal_id, current_user.goals.map{|g|[g.title, g.id]}, {:include_blank => true}}", 'MESSAGE' => I18n.t('action.create_successfully')}.to_json
        }
      end
    else
      
      respond_to do |format|
        format.html { render :action => 'new' }
        format.js { render :json => {"FAIL" => I18n.t('action.create_fail')}.to_json} 
      end
    end
  end
  
  def edit
    @goal = current_user.goals.find(params[:id])
  end
  
  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update_attributes(params[:goal])
      flash[:notice] = I18n.t("action.update_successfully")
      redirect_to @goal
    else
      flash[:error] = I18n.t("action.update_fail")
      render :action => 'edit'
    end
  end
  
  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    flash[:notice] = I18n.t("action.destroy_successfully")
    redirect_to user_home_path(current_user.username) 
  end
end

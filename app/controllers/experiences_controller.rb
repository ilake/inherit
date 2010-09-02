class ExperiencesController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :force_set_profile
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:index]
  load_and_authorize_resource :nested => :user

  # GET /experiences
  # GET /experiences.xml
  # cache : params.values.sort.to_s
  def index
    @experiences = user_selected.experiences.show_policy(@user.is_owner?(current_user)).goal_categroy(params[:goal_id]).descend_by_position.limit(current_data_number(params[:data_number]))

    @experience_groups = @experiences.group_by{|e| e.start_at.at_beginning_of_month}

    if @current_goal = Goal.find_by_id(params[:goal_id])
      @goals = Array.new(1, @current_goal)
      @related_goals = @current_goal.find_related_goals(current_user_location)
    else
      @goals = user_selected.goals.show_policy(@user.is_owner?(current_user)).not_category.descend_by_created_at
    end

    @events = timeline_events(@experiences, @goals).to_json
    @fan = @user.fan(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @experiences }
    end
  end

  # GET /experiences/1
  # GET /experiences/1.xml
  def show
    @experience = Experience.find(params[:id])
    @comments = @experience.comments.recent.find(:all, :include => :user)

    @comment = @experience.comments.new
    @vote = @experience.votes.new
    @current_goal = Goal.find_by_id(params[:goal_id]) 
    @related_exps = @experience.find_related_exps(current_user_location)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experience }
    end
  end

  # GET /experiences/new
  # GET /experiences/new.xml
  def new
    @experience = Experience.new(:goal_id => params[:goal_id])
#    if params[:question_id]
#      @question = Question.find(params[:question_id])
#    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @experience }
    end
  end

  # GET /experiences/1/edit
  def edit
    @experience = current_user.experiences.find(params[:id])
  end

  # POST /experiences
  # POST /experiences.xml
  def create
    @experience = current_user.experiences.new(params[:experience])
    @question = Question.find(params[:question_id]) if !params[:question_id].blank?
    respond_to do |format|
      if @experience.save
        @experience.answer_questions << @question if @question
        current_user.tag(@experience, :with => @experience.tag_list, :on => :tags)
        flash[:notice] = I18n.t('action.create_successfully')
        format.html { 
          if @question
            redirect_to @question
          else
            #redirect_to user_home_path(current_user) 
            redirect_to @experience
          end
        }
        format.xml  { render :xml => @experience, :status => :created, :location => @experience }
      else
        flash[:error] = I18n.t('action.create_fail')
        format.html { render :action => "new" }
        format.xml  { render :xml => @experience.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /experiences/1
  # PUT /experiences/1.xml
  def update
    @experience = current_user.experiences.find(params[:id])
    @question = Question.find(params[:question_id]) if !params[:question_id].blank?
    respond_to do |format|
      if @experience.update_attributes(params[:experience])
        current_user.tag(@experience, :with => @experience.tag_list.to_s, :on => :tags)

        flash[:notice] = I18n.t('action.update_successfully')
        format.html { 
          redirect_to @experience
          #redirect_to user_home_path(current_user) 
        }
        format.xml  { head :ok }
      else
        flash[:error] = I18n.t('action.update_fail')
        format.html { render :action => "edit" }
        format.xml  { render :xml => @experience.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.xml
  def destroy
    @experience = current_user.experiences.find(params[:id])
    @experience.destroy

    flash[:notice] = I18n.t('action.destroy_successfully')
    respond_to do |format|
      format.html { redirect_to(user_experiences_url(current_user)) }
      format.xml  { head :ok }
    end
  end

  def select
    @experiences = current_user.experiences.public_equals(true)
    @question = Question.find(params[:question_id])
  end
end

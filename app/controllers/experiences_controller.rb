class ExperiencesController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:index]
  load_and_authorize_resource :nested => :user
  before_filter :force_set_profile

  # GET /experiences
  # GET /experiences.xml
  def index
    @experiences = user_selected.experiences.descend_by_start_at.find(:all, :include => [:goal])
    @experience_groups = @experiences.group_by{|e| e.start_at.at_beginning_of_month}
    @goals = user_selected.goals.all

    @events = @experiences.map{ |e|
      end_time_hash = e.start_at.to_s(:date) == e.end_at.to_s(:date) ? {} : {'end' =>  e.end_at.to_s(:date)}
      {
      'start' => e.start_at.to_s(:date),
      'title' => ApplicationController.helpers.truncate_u(Sanitize.clean(e.content), 20),
      'description' => e.content,
      'color' => "##{rand(10)}#{rand(10)}#{rand(10)}",
      'icon' => "/images/timeline/dark-red-circle.png"
      }.merge!(end_time_hash)
    }.to_json

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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experience }
    end
  end

  # GET /experiences/new
  # GET /experiences/new.xml
  def new
    @experience = Experience.new(:goal_id => params[:goal_id])
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
    respond_to do |format|
      if @experience.save
        current_user.tag(@experience, :with => @experience.tag_list, :on => :tags)
        flash[:notice] = 'Experience was successfully created.'
        format.html { redirect_to user_experiences_path(current_user) }
        format.xml  { render :xml => @experience, :status => :created, :location => @experience }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @experience.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /experiences/1
  # PUT /experiences/1.xml
  def update
    @experience = current_user.experiences.find(params[:id])
    respond_to do |format|
      if @experience.update_attributes(params[:experience])
        current_user.tag(@experience, :with => @experience.tag_list.to_s, :on => :tags)

        flash[:notice] = 'Experience was successfully updated.'
        format.html { redirect_to user_experiences_path(current_user) }
        format.xml  { head :ok }
      else
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

    respond_to do |format|
      format.html { redirect_to(user_experiences_url(current_user)) }
      format.xml  { head :ok }
    end
  end
end

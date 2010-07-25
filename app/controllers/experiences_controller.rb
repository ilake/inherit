class ExperiencesController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:index]
  load_and_authorize_resource :nested => :user
  before_filter :force_set_profile

  # GET /experiences
  # GET /experiences.xml
  # cache : params.values.sort.to_s
  def index
    @experiences = user_selected.experiences.show_policy(@user.is_owner?(current_user)).goal_categroy(params[:goal_id]).descend_by_position.limit(current_data_number(params[:data_number]))
    @current_goal = Goal.find_by_id(params[:goal_id])
    @experience_groups = @experiences.group_by{|e| e.start_at.at_beginning_of_month}
    @goals = user_selected.goals.show_policy(@user.is_owner?(current_user)).not_category.descend_by_start_at
    @categories = user_selected.goals.show_policy(@user.is_owner?(current_user)).is_category.descend_by_created_at
    @fan = @user.fan(current_user)

    events = @experiences.map{ |e|
      #Does not have end_at or start_at equal to end_at
      end_time_hash = e.end_at_hash
      {
      'start' => e.start_at.to_s(:date),
      'title' => app_helpers.truncate_u(Sanitize.clean(e.content), 10),
      'description' => "
      <span class='function'>
      #{app_helpers.link_to '編輯', edit_experience_path(e) if can? :update, e}
      #{app_helpers.link_to('刪除', destroy_experience_path(e), :confirm => 'Are you sure') if can? :destroy, e}
      #{app_helpers.link_to('<strong>詳細內容</strong>', experience_path(e), :popup => true)}
      </span>
      <br /> 
      #{app_helpers.truncate_u(Sanitize.clean(e.content), 100)}",
      'color' => e.color,
      'icon' => "/images/timeline/dark-red-circle.png"
      }.merge!(end_time_hash)
    }

     @goals.not_category.each { |g|
      #end_time_hash = g.end_at_hash
       events << {
          'start' => g.start_at.to_s(:date),
          'title' => g.title,
          'description' => "
      <span class='function'>
          #{app_helpers.link_to '編輯', edit_goal_path(g) if can? :update, g}
          #{app_helpers.link_to('刪除', destroy_goal_path(g)) if can? :destroy, g}
          #{app_helpers.link_to('<strong>詳細內容</strong>', goal_path(g), :popup => true)}
      </span>
          <br /> 
          #{app_helpers.truncate_u(Sanitize.clean(g.content), 100)}",
          'color' => "##{rand(10)}#{rand(10)}#{rand(10)}",
          'icon' => "/images/timeline/#{['gray', 'green', 'red'].rand}-circle.png"
       }#.merge!(end_time_hash)
    }
    @events = events.to_json

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
    @questions = @experience.answer_questions.limit(5)

    @comment = @experience.comments.new
    @vote = @experience.votes.new
    @current_goal = Goal.find(params[:goal_id]) if params[:goal_id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experience }
    end
  end

  # GET /experiences/new
  # GET /experiences/new.xml
  def new
    @experience = Experience.new(:goal_id => params[:goal_id])
    if params[:question_id]
      @question = Question.find(params[:question_id])
    end
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
        flash[:notice] = 'Experience was successfully created.'
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

        flash[:notice] = 'Experience was successfully updated.'
        format.html { 
          redirect_to @experience
          #redirect_to user_home_path(current_user) 
        }
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

  def select
    @experiences = current_user.experiences.public_equals(true)
    @question = Question.find(params[:question_id])
  end
end

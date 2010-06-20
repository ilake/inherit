class QuestionsController < ApplicationController
  uses_tiny_mce(:options => AppConfig.simple_mce_options, :only => [:new, :edit]) if defined?(AppConfig)
  before_filter :authenticate_user!, :except => [:index , :show]
  load_and_authorize_resource :nested => :user

  def index
    @questions = Question.location_with(current_user_location).descend_by_created_at.paginate :per_page => 15, :page => params[:page]
  end
  
  def show
    @question = Question.find(params[:id])
    @comments = @question.comments.recent.find(:all, :include => :user)
    @experiences = @question.experiences.descend_by_updated_at.limit(5)

    @comment = @question.comments.new
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = current_user.questions.new(params[:question])
    if @question.save
      flash[:notice] = "Successfully created question."
      redirect_to @question
    else
      render :action => 'new'
    end
  end
  
  def edit
    @question = current_user.questions.find(params[:id])
  end
  
  def update
    @question = current_user.questions.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Successfully updated question."
      redirect_to @question
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Successfully destroyed question."
    redirect_to questions_url
  end
end

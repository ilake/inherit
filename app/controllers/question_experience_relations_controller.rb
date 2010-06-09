class QuestionExperienceRelationsController < ApplicationController
  def index
    @question_experience_relations = QuestionExperienceRelation.all
  end
  
  def show
    @question_experience_relation = QuestionExperienceRelation.find(params[:id])
  end
  
  def new
    @question_experience_relation = QuestionExperienceRelation.new
  end
  
  def create
    @question_experience_relation = QuestionExperienceRelation.new(params[:question_experience_relation])
    if @question_experience_relation.save
      flash[:notice] = "Successfully created question experience relation."
      redirect_to @question_experience_relation
    else
      render :action => 'new'
    end
  end
  
  def edit
    @question_experience_relation = QuestionExperienceRelation.find(params[:id])
  end
  
  def update
    @question_experience_relation = QuestionExperienceRelation.find(params[:id])
    if @question_experience_relation.update_attributes(params[:question_experience_relation])
      flash[:notice] = "Successfully updated question experience relation."
      redirect_to @question_experience_relation
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @question_experience_relation = QuestionExperienceRelation.find(params[:id])
    @question_experience_relation.destroy
    flash[:notice] = "Successfully destroyed question experience relation."
    redirect_to question_experience_relations_url
  end
end

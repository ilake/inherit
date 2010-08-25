class VotesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show]
  def index
    @experience = Experience.find(params[:experience_id])
    @users = @experience.voters_who_voted
  end
  
  def show
    @vote = Vote.find(params[:id])
  end
  
  def new
    @vote = Vote.new
  end
  
  def create
    if current_user.vote(params[:voteable_type].constantize.find(params[:exp_id]), params[:vote].to_i)
      flash[:notice] = I18n.t("vote.result")
    else
      flash[:error] =  I18n.t("vote.result")
    end
    redirect_to :back
  end
  
  def edit
    @vote = Vote.find(params[:id])
  end
  
  def update
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(params[:vote])
      flash[:notice] = "Successfully updated vote."
      redirect_to @vote
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    flash[:notice] = I18n.t("vote.destroy")
    redirect_to votes_url
  end
end

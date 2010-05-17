class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end
  
  def show
    @vote = Vote.find(params[:id])
  end
  
  def new
    @vote = Vote.new
  end
  
  def create
    if current_user.vote(params[:voteable_type].constantize.find(params[:exp_id]), params[:vote].to_i)
      flash[:notice] = "Thank for your advice."
    else
      flash[:error] = "Thank for your advice."
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
    flash[:notice] = "Successfully destroyed vote."
    redirect_to votes_url
  end
end

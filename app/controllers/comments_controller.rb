class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show]
  def index
    @comments = Comment.all
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    comment = current_user.comments.new(params[:comment])
    if comment.save
      flash[:notice] = I18n.t("action.create_successfully")
      redirect_to :back
    else
      flash[:error] = I18n.t("action.create_fail")
      redirect_to :back
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = I18n.t("action.update_successfully")
      redirect_to @comments
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = I18n.t("action.destroy_successfully")
    redirect_to comments_url
  end
end

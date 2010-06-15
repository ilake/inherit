class ChatsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show]

  def index
    @chats = Chat.origin.find(:all, :include => [:user, :children])
    @chat = Chat.new
  end
  
  def show
    @chat = Chat.find(params[:id])
  end
  
  def new
    @chat = Chat.new
  end

  def reply
    @chat = Chat.find(params[:chat_id]).children.new
    render :action => 'new'
  end
  
  def create
    @chat = current_user.chats.new(params[:chat])
    if @chat.save
      flash[:notice] = "Successfully created chat."
      redirect_to chats_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @chat = Chat.find(params[:id])
  end
  
  def update
    @chat = Chat.find(params[:id])
    if @chat.update_attributes(params[:chat])
      flash[:notice] = "Successfully updated chat."
      redirect_to @chat
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    flash[:notice] = "Successfully destroyed chat."
    redirect_to chats_url
  end
end

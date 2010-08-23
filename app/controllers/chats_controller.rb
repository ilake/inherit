class ChatsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show]
  before_filter :user_selected, :only => [:reply ]

  def index
    if params[:user_id]
      @chats = user_selected.own_chats.location_with(current_user_location).origin.descend_by_created_at.paginate :per_page => 15, :page => params[:page], :include => [:user, :children]
      @chat = Chat.new(:master_id => user_selected.id, :user_id => current_user.try(:id))
    else
      @chats = Chat.location_with(current_user_location).for_admin.origin.descend_by_created_at.paginate :per_page => 15, :page => params[:page], :include => [:user, :children]
      @chat = Chat.new
    end
  end

  def show
    @chat = Chat.find(params[:id])
  end
  
  def new
    @chat = current_user.leave_chats.new(:master_id => user_selected.id)
  end

  def reply
    @chat = Chat.find(params[:chat_id]).children.new(:master_id => user_selected.id)
    render :action => 'new'
  end
  
  def create
    @chat = current_user.leave_chats.new(params[:chat])
    if @chat.save
      flash[:notice] = I18n.t("action.create_successfully")
      if @chat.owner
        redirect_to user_chats_path(@chat.owner)
      else
        redirect_to chats_path
      end
    else
      flash[:error] = I18n.t("action.create_fail")
      render :action => 'new'
    end
  end
  
  def edit
    @chat = Chat.find(params[:id])
  end
  
  def update
    @chat = Chat.find(params[:id])
    if @chat.update_attributes(params[:chat])
      flash[:notice] = I18n.t("action.update_successfully")
      redirect_to @chat
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    flash[:notice] = I18n.t("action.destroy_successfully")
    redirect_to :back
  end
end

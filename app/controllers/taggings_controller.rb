class TaggingsController < ApplicationController
#  def index
#    @taggings = Taggings.all
#  end
  
  def show
    #@taggable_objs = params[:taggable_type].try(:constantize).try(:tagged_with, params[:id])
    @taggable_objs = params[:taggable_type].try(:constantize).search params[:id], :page => params[:page], :per_page => 15
    #@taggable_objs = Experience.search params[:id], :page => params[:page], :per_page => 15
    @taggable_objs ||= []
  end
  
#  def new
#    @taggings = Taggings.new
#  end
#  
#  def create
#    @taggings = Taggings.new(params[:taggings])
#    if @taggings.save
#      flash[:notice] = "Successfully created taggings."
#      redirect_to @taggings
#    else
#      render :action => 'new'
#    end
#  end
#  
#  def edit
#    @taggings = Taggings.find(params[:id])
#  end
#  
#  def update
#    @taggings = Taggings.find(params[:id])
#    if @taggings.update_attributes(params[:taggings])
#      flash[:notice] = "Successfully updated taggings."
#      redirect_to @taggings
#    else
#      render :action => 'edit'
#    end
#  end
#  
#  def destroy
#    @taggings = Taggings.find(params[:id])
#    @taggings.destroy
#    flash[:notice] = "Successfully destroyed taggings."
#    redirect_to taggings_url
#  end
end

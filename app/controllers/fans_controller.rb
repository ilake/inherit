class FansController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show]

  def create
    fan = Fan.new(params[:fan])
    if fan.save
      flash[:notice] = "Follow Successfully."
    else
      flash[:error] = "Follow Fail."
    end
    redirect_to :back
  end

  def destroy
    fan = Fan.find(params[:id])
    
    if fan.destroy
      flash[:notice] = "Unfollow Successfully."
    else
      flash[:error] = "Unfollow Fail."
    end
    redirect_to :back
  end
end

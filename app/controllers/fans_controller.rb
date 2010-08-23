class FansController < ApplicationController
  before_filter :authenticate_user!, :except => [:index , :show, :ifollow]
  def index
    @users = User.find(params[:user_id]).user_fans
  end

  def ifollow
    @users = User.find(params[:user_id]).ifollow
    render :action => 'index'
  end

  def create
    fan = Fan.new(params[:fan])
    if fan.save
      flash[:notice] = I18n.t("fans.follow_successfully")
    else
      flash[:error] = I18n.t("fans.follow_fail")
    end
    redirect_to :back
  end

  def destroy
    fan = Fan.find(params[:id])
    
    if fan.destroy
      flash[:notice] = I18n.t("fans.unfollow_successfully")
    else
      flash[:error] = I18n.t("fans.unfollow_fail")
    end
    redirect_to :back
  end
end

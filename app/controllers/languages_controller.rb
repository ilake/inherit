class LanguagesController < ApplicationController
  def edit
    cookies[:locale] = params[:locale]
    if request.env["HTTP_REFERER"]
      redirect_to :back
    else
      redirect_to :controller => 'main', :action => 'index'
    end
  end
end

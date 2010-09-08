class SiteController < ApplicationController
  skip_before_filter :ip_location

  def about
  end
end

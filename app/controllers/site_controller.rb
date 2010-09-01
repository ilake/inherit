class SiteController < ApplicationController
  skip_before_filter :ip_location
  caches_page :about

  def about
  end
end

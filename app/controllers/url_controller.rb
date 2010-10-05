class UrlController < ApplicationController
  require 'open-uri'
  skip_before_filter :ip_location, :set_locale
  session :off

  def create
    #request.env['QUERY_STRING'] would like this "url=http://www.myoops.org/main.php?act=course&id=497"

    doc = open(request.env['QUERY_STRING'].sub!(/url=/,'')) { |f| Hpricot(f) }
    title = doc.search('title').inner_html
    if meta_desc = doc.search("meta[@name='description']").first
      content = meta_desc.attributes['content']
    end

    if content.blank?
      content = Sanitize.clean(doc.search("p").first.try(:inner_html))
    end

    if content.blank?
      content = Sanitize.clean(doc.search("a").first.try(:inner_html))
    end

    render :partial => "url_title_desc", :locals => {:title => title, :content => content, :url => params[:url]}
  end
end

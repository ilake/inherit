class UrlController < ApplicationController
  require 'open-uri'
  skip_before_filter :ip_location, :set_locale
  session :off

  def create
    #request.env['QUERY_STRING'] would like this "url=http://www.myoops.org/main.php?act=course&id=497"

    rsp = open(request.env['QUERY_STRING'].sub!(/url=/,''))
    begin 
      doc = Hpricot.parse(rsp)
      title = doc.search('title').inner_html
      if meta_desc = doc.search("meta[@name='description']").first
        content = meta_desc.attributes['content']
      end
      content = Sanitize.clean(doc.search("p").first.try(:inner_html)) if content.blank?
      content = Sanitize.clean(doc.search("a").first.try(:inner_html)) if content.blank?
    rescue
      doc = Nokogiri::HTML(rsp)
      title = doc.search('title').text
      if meta_desc = doc.search("meta[@name='description']").first
        content = meta_desc.values[1]
      end
      content = Sanitize.clean(doc.search("p").first.try(:content)) if content.blank?
      content = Sanitize.clean(doc.search("a").first.try(:content)) if content.blank?
    end

#      if image = doc.search("img").first
#        img = image.values[0]
#      end

    render :partial => "url_title_desc", :locals => {:title => title, :content => content, :url => params[:url]}
  end

end

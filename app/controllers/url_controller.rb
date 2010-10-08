class UrlController < ApplicationController
  require 'open-uri'
  skip_before_filter :ip_location, :set_locale
  session :off

  def create
    #request.env['QUERY_STRING'] would like this "url=http://www.myoops.org/main.php?act=course&id=497"
    url = request.env['QUERY_STRING'].sub!(/url=/,'')
    rsp = open(url)
    utf8_encode = rsp.charset.match(/utf-8/)

    begin 
      doc = Hpricot.parse(rsp)

      title = doc.search('title').inner_html
      if meta_desc = doc.search("meta[@name='description']").first
        content = meta_desc.attributes['content']
      end
      content = Sanitize.clean(doc.search("p").first.try(:inner_html).to_s) if content.blank?
      content = Sanitize.clean(doc.search("a").first.try(:inner_html).to_s) if content.blank?
      content = url if content.blank?

      unless utf8_encode
        content_encode = doc.search("meta[@http-equiv='Content-Type']").first.attributes['content'].match(/charset=(.*)/)[1]
        title = Iconv.iconv("UTF-8//IGNORE","#{content_encode}//IGNORE", title)
        content = Iconv.iconv("UTF-8//IGNORE","#{content_encode}//IGNORE", content)
      end

    rescue
      doc = Nokogiri::HTML(rsp)
      title = doc.search('title').text
      if meta_desc = doc.search("meta[@name='description']").first
        content = meta_desc.values[1]
      end
      content = Sanitize.clean(doc.search("p").first.try(:content).to_s) if content.blank?
      content = Sanitize.clean(doc.search("a").first.try(:content).to_s) if content.blank?
      content = url if content.blank?

#      unless utf8_encode
#        content_encode = doc.search("meta[@http-equiv='Content-Type']").first.values[1].match(/charset=(.*)/)[1]
#        title = Iconv.iconv("UTF-8//IGNORE","#{content_encode}//IGNORE", title)
#        content = Iconv.iconv("UTF-8//IGNORE","#{content_encode}//IGNORE", content)
#      end
    end
#      if image = doc.search("img").first
#        img = image.values[0]
#      end

    render :partial => "url_title_desc", :locals => {:title => title, :content => content, :url => url}
  end

end

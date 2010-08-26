# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
#  def title(page_title, show_title = true)
#    @content_for_title = page_title.to_s
#    @show_title = show_title
#  end
#  
#  def show_title?
#    @show_title
#  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args.map(&:to_s)) }
  end
  
  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:head) { javascript_include_tag(*args) }
  end

  def user_current_view_location(location)
#    s = []
#    if current_user_location == "World"
#      s << 'World'
#      s << link_to(user_hometown, {:location => user_hometown}, :rel => "facebox") if user_hometown
#    else
#      s << link_to('World', :location => 'World')
#      s << user_hometown if user_hometown
#    end
#    s.join(' > ')
     link_to(current_user_location, user_location_url, :rel => "facebox")
  end

  def facebook_like
    content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=standard&show_faces=true&width=450&action=like&font=arial&colorscheme=light&height=80", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end

  def facebook_share
    '<a name="fb_share" type="button_count" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>'
  end

  def share_button
    if current_user_location == 'China'
      '<!-- JiaThis Button BEGIN -->
    <a href="http://www.jiathis.com/share/" class="jiathis" target="_blank"><img src="http://www.jiathis.com/code/images/jiathis2.gif" width="125" height="21" border="0" id="jiathis_a"/></a>
    <script type="text/javascript" src="http://www.jiathis.com/code/jia.js" charset="utf-8"></script>
    <!-- JiaThis Button END -->'
    else
      '<!-- AddToAny BEGIN -->
    <a class="a2a_dd" href="http://www.addtoany.com/share_save"><img src="http://static.addtoany.com/buttons/share_save_171_16.png" width="171" height="16" border="0" alt="Share/Bookmark"/></a>
    <script type="text/javascript">
    var a2a_config = a2a_config || {};
    a2a_config.num_services = 10;
    </script>
    <script type="text/javascript" src="http://static.addtoany.com/menu/page.js"></script>
    <!-- AddToAny END -->'
    end
  end

  def language_selection
    r = []
    LOCALES_AVAILABLE.each do |language|
      r << link_to_unless(I18n.locale == language, t(language), change_lang_path(:locale => language)) + "&nbsp;" 
    end
    r
  end
end

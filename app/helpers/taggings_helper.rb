module TaggingsHelper
  def tag_link(obj, option = {:class => 'space'})
    cls = obj.class
    obj.tag_list.each do |t|
      concat(content_tag(:span, (link_to t, tag_url(:id => t, :taggable_type => cls)), option))
    end
  end
end

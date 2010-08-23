module ExperiencesHelper
  def timeline_start_time(user)
#    if time = experiences.last.try(:start_at).try(:to_s, :js_date)
#      time
    #elsif time = user.try(:birthday).try(:to_s, :js_date) 
    if time = user.try(:birthday).try(:to_s, :js_date) 
      time
    else 
      Time.now.ago(1.years).to_s(:js_date)
    end
  end

  def user_content_display_state(current_goal)
    current_goal ? 'show' : 'hide'
  end

  def exp_tag_list(array)
    array.each do |name|
      concat(content_tag(:span, link_to(name, search_url(name)), :class => 'space'))
    end
  end
end

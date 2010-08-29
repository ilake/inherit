# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ntp(number)
    number_to_percentage(number, :precision => 0)
  end

  def link_to_user_home(user)
    link_to "#{h user.showname}", user_home_path(user.username)
  end

  def current_tab(p_state, tab_state)
    p_state == tab_state ? 'active' : ''
  end

  include WillPaginate::ViewHelpers 
  def will_paginate_with_i18n(collection, options = {}) 
    will_paginate_without_i18n(collection, options.merge(:previous_label => I18n.t('paginate.previous'), :next_label => I18n.t('paginate.next'))) 
  end 
   
  alias_method_chain :will_paginate, :i18n 
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ntp(number)
    number_to_percentage(number, :precision => 0)
  end

  def link_to_user_home(user)
    link_to "#{h user.showname}", user_home_path(user.username)
  end
end

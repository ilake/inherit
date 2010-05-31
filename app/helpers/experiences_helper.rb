module ExperiencesHelper
  def timeline_start_time(user, experiences)
    if time = experiences.last.try(:start_at).try(:to_s, :js_date)
      time
    elsif time = user.try(:birthday).try(:to_s, :js_date) 
      time
    else 
      Time.now.ago(1.years).to_s(:js_date)
    end
  end
end

module SearchHelper
  def search_page_meta_tag(questions, goals, experiences)
    if !experiences.blank?  && experiences.last
      "#{truncate_u(Sanitize.clean(experiences.last.content), 100)}"
    elsif !questions.blank? && questions.last
      "#{truncate_u(Sanitize.clean(questions.last.content), 100)}"
    elsif !goals.blank? && goals.last
      "#{truncate_u(Sanitize.clean(goals.last.content), 100)}"
    else
      ""
    end
  end
end

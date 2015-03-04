module ApplicationHelper
  def format_date(date, without_hours: true)
    if date.is_a?(String)
      DateTime.parse(date.to_s).strftime(formater_string(without_hours: without_hours))
    else
      date.strftime(formater_string(without_hours: without_hours))
    end
  end

  def formater_string(without_hours: true)
    without_hours ? "%B %-d, %Y" : "<p>%B %-d, %Y</p><p>%r</p>"
  end
end

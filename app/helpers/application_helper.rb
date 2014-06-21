module ApplicationHelper
  def format_date(date)
    DateTime.parse(date).strftime('%B %-d, %Y')
  end
end

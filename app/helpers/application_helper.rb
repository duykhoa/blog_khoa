module ApplicationHelper
  def format_date(date)
    DateTime.parse(date).strftime('%B %-d, %Y')
  end

  def pagination_previous(articles, page)
    if page && page.to_i > 1
      content_tag :div, class: 'previous' do
        link_to 'Previous Page', url_for(page: page.to_i - 1)
      end
    end
  end

  def pagination_next(articles, page)
    if !page || page.to_i < total_page(articles.total_count)
      content_tag :div, class: 'next' do
        link_to 'Next Page', url_for(page: page.to_i + 1)
      end
    end
  end

  def total_page(total)
    (total.to_f / Article::PER_PAGE).ceil
  end
end

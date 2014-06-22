module ArticlesHelper
  require 'uri'

  def encode_url(text)
    URI.encode text
  end

  def form_search_path(params)
    params.has_key?(:category_name) ? \
      category_index_path(params[:category_name]) : \
      search_path
  end
end

json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :short_content
  json.url article_url(article, format: :json)
end

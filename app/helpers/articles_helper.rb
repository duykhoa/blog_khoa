module ArticlesHelper
  require 'uri'

  def encode_url(text)
    URI.encode text
  end
end

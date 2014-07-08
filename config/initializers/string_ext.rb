class String
  def parameterize_string
    downcase.gsub(/\W/, '-')
  end
end

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Articles"
    xml.description BlogSetting.fb_description
    xml.link articles_url(:rss)

    xml.items do
      for article in @articles
        xml.item do
          xml.title article.title
          xml.short_content article.content
          xml.feature_image article.feature_image
          xml.link article_url(article.slug)
        end
      end
    end
  end
end

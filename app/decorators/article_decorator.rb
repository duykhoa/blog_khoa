class ArticleDecorator < Draper::Decorator
  delegate_all

  def publish_type
    publish ? "<span class='label published'>Published</span>" : "<span class='label draft'>Draft</span>"
  end
end

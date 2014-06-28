class BlogSeo < ActiveRecord::Base
  after_initialize :after_initialize

  def after_initialize
    self.value = "<meta property='og:title' content='#{BlogSetting.blog_title}' />"
  end

  rails_admin do
    list do
      field :value
    end
  end
end

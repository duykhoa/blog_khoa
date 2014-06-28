class BlogSeo < ActiveRecord::Base
  after_initialize :after_initialize
  validates :value, presence: true

  def after_initialize
    self.value = "<meta property='og:title' content='#{BlogSetting.blog_title}' />" if value.blank?
  end

  def self.metatags
    @@metatags ||= BlogSeo.all.map(&:value)
  end

  after_save :clear_metatags

  rails_admin do
    list do
      field :value
    end
  end

  private

  def clear_metatags
    @@metatags = nil
  end
end

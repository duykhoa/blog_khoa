class Article < ActiveRecord::Base
  has_attached_file(
    :feature_image,
    styles:
      { :medium => "450x450>", :thumb => "100x100>" },
    default_url: "/images/missing.png")

  validates_attachment_content_type :feature_image, :content_type => /\Aimage\/.*\Z/

  extend FriendlyId
  friendly_id :article_url, use: [:slugged, :finders]

  def article_url
    [:title]
  end

  default_scope lambda { order(created_at: :desc) }

  def related_articles(number = 3)
    self.class.where.not(id: id).limit(number)
  end

  rails_admin do
    edit do
      field :title
      field :short_content
      field :content, :ck_editor
    end
  end
end

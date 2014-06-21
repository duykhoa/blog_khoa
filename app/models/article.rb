class Article < ActiveRecord::Base
  has_attached_file(
    :feature_image,
    styles:
      { :medium => "450x450>", :thumb => "100x100>" },
    default_url: "/images/missing.png")

  PER_PAGE = 8

  validates_attachment_content_type :feature_image, :content_type => /\Aimage\/.*\Z/

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name "blog_khoa_#{Rails.env}"

  extend FriendlyId
  friendly_id :article_url, use: [:slugged, :finders]

  def article_url
    [:title]
  end

  default_scope lambda { order(created_at: :desc) }

  def related_articles(number = 3)
    self.class.where.not(id: id).limit(number)
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :title, type: 'string', analyzer: 'snowball', boost: 5
    indexes :content, type: 'string', analyzer: 'snowball'
    indexes :short_content, type: 'string', analyzer: 'snowball'
    indexes :feature_image, as: 'feature_image.url(:medium)', type: 'string'
    indexes :created_at, type: 'date'
    indexes :slug, index: :not_analyzed
  end

  class << self
    def search(params)
      tire.search(page: params[:page], per_page: PER_PAGE) do
        query do
          if params[:query].present? && params[:query] != '-'
            string params[:query], fields: %W(title short_content content)
          else
            all
          end
        end

        sort do
          by :created_at, 'desc'
        end
      end
    end
  end

  rails_admin do
    edit do
      field :title
      field :short_content
      field :content, :ck_editor
    end
  end
end

class Article < ActiveRecord::Base
  include PaginationExt

  has_attached_file(
    :feature_image,
    styles:
      { :medium => "750x500#", :thumb => "100x100>" },
    default_url: "/images/missing.png")

  PER_PAGE = 4
  belongs_to :category
  validates :category, presence: true

  validates_attachment_content_type :feature_image, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name "blog_khoa_#{BlogSetting.blog_title.parameterize rescue 'test'}"

  extend FriendlyId
  friendly_id :article_url_slug, use: [:slugged, :finders]

  def article_url_slug
    title.to_url
  end

  default_scope lambda { order(created_at: :desc) }

  def related_articles(number = 3)
    self.class.where.not(id: id).limit(number)
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :title, type: 'string', analyzer: 'snowball', boost: 5
    indexes :title_latin, as: 'title.to_url', type: 'string', analyzer: 'snowball', boost: 5
    indexes :content, type: 'string', analyzer: 'snowball'
    indexes :content_latin, as: 'content.to_url', type: 'string', analyzer: 'snowball'
    indexes :short_content, type: 'string', analyzer: 'snowball'
    indexes :short_content_latin, as: 'short_content.to_url', type: 'string', analyzer: 'snowball'
    indexes :feature_image, as: 'feature_image.url(:medium)', type: 'string'
    indexes :category_name, as: 'category.sanitize_name', type: 'string', index: :not_analyzed
    indexes :created_at, type: 'date'
    indexes :slug, index: :not_analyzed
  end

  class << self
    def search(search_params = {})
      tire.search(page: Article.page_params(search_params), per_page: PER_PAGE) do
        query do
          if search_params[:query].present? && search_params[:query] != '-'
            string search_params[:query], fields: %W(title title_latin short_content short_content_latin content content_latin)
          else
            all
          end
        end

        if search_params[:category_name].present? && search_params[:category_name] != '-'
          filter :term, category_name: search_params[:category_name]
        end

        sort do
          by :created_at, 'desc'
        end
      end
    end

    def decode(params)
      params.gsub('-', ' ')
    end
  end

  rails_admin do
    edit do
      field :title
      field :short_content
      field :category
      field :feature_image
      field :content, :ck_editor
    end
  end
end

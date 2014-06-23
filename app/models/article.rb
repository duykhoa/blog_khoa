class Article < ActiveRecord::Base
  has_attached_file(
    :feature_image,
    styles:
      { :medium => "450x450>", :thumb => "100x100>" },
    default_url: "/images/missing.png")

  PER_PAGE = 8
  belongs_to :category

  validates_attachment_content_type :feature_image, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true

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
    indexes :category_name, as: 'category.name', type: 'string', index: :not_analyzed
    indexes :created_at, type: 'date'
    indexes :slug, index: :not_analyzed
  end

  class << self
    def search(search_params = {}, page_params = 1)
      page = search_params.fetch(:page) || 1
      tire.search(page: page, per_page: PER_PAGE) do
        query do
          if search_params[:query].present? && search_params[:query] != '-'
            string search_params[:query], fields: %W(title short_content content)
          else
            all
          end
        end

        if search_params[:category_name].present? && search_params[:category_name] != ''
          filter :term, category_name: Article.decode(search_params[:category_name])
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

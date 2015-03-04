class Article < ActiveRecord::Base
  default_scope lambda { order(created_at: :desc) }

  PER_PAGE = 5
  DRAFT = "Save Draft"

  has_attached_file :feature_image, :styles => { :medium => "730x400#" }, :default_url => "missing.png"
  validates_attachment_content_type :feature_image, :content_type => /\Aimage\/.*\Z/

  attr_accessor :commit

  belongs_to :category

  validates :category, presence: true
  validates :title, presence: true
  validates :short_content, length: { maximum: 500 }

  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name "duykhoa_#{Rails.env}"

  extend FriendlyId
  friendly_id :article_url_slug, use: [:slugged, :finders]

  def article_url_slug
    title.to_url if title
  end

  def related_articles(number = 4)
    self.class.where.not(id: id).limit(number)
  end

  def create_or_update_with_commit_type(commit_type)
    self.publish = published_status(commit_type)
    self.save
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  mapping do
    indexes :id, type: 'integer'
    indexes :title, type: 'string', analyzer: 'snowball', boost: 5
    indexes :title_latin, as: 'title.to_url', type: 'string', analyzer: 'snowball', boost: 5
    indexes :content, type: 'string', analyzer: 'snowball'
    indexes :content_latin, as: 'content.to_url', type: 'string', analyzer: 'snowball'
    indexes :short_content, type: 'string', analyzer: 'snowball'
    indexes :short_content_latin, as: 'short_content.to_url', type: 'string', analyzer: 'snowball'
    indexes :category_name, as: 'category.sanitize_name', type: 'string', index: :not_analyzed
    indexes :category_latin, as: 'category.name', type: 'string', index: :not_analyzed
    indexes :created_at, type: 'date'
    indexes :slug, index: :not_analyzed
    indexes :feature_image, as: 'feature_image.url(:medium)', index: :not_analyzed
    indexes :publish, type: 'boolean', index: :not_analyzed
  end

  class << self
    def page(params)
      params.key?(:page) ? params[:page] : 1
    end

    def search(finder = nil, search_params = {})
      tire.search(per_page: PER_PAGE, page: page(search_params)) do
        if search_params.key?(:category_name) && search_params[:category_name] != '-'
          filter :term, category_name: search_params[:category_name]
        end

        unless finder.eql?(:all)
          filter :term, publish: true
        end

        query do
          if search_params[:query].present? && search_params[:query] != '-'
            string search_params[:query], fields: %W(title title_latin short_content short_content_latin content content_latin)
          else
            all
          end
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

  private

  def published_status(commit_type)
    commit_type.eql?(DRAFT) ? false : true
  end
end

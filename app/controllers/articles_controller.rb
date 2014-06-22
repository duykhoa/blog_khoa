class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy]

  def index
    @articles = Article.search()
  end

  def category_index
    @articles = Article.search(category_params)
    render 'index'
  end

  def show
  end

  def search
    redirect_to search_seo_friendly_path(search_params)
  end

  def search_seo_friendly
    @articles = Article.search params
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def sanitize_params(arg)
      arg ? arg.gsub(/\W/, '-') : '-'
    end

    def search_params
      params.permit(:query, :page).tap do |args|
        args[:query] = sanitize_params args[:query]
      end
    end

    def category_params
      params.permit(:category_name, :page, :query).tap do |args|
        args[:category_name] = sanitize_params args[:category_name]
        args[:query] = sanitize_params args[:query]
      end
    end
end

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy]

  def index
    @articles = Article.search({})
  end

  def show
  end

  def search
    redirect_to search_seo_friendly_path(query: sanitize_search_params)
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

    def sanitize_search_params
      params[:query] ? params[:query] : '-'
    end

    def search_params
      params.permit(:query, :page)
    end
end

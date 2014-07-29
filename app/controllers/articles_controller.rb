class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  include ParamsExt

  def index
    @articles = Article.search(index_params)
  end

  def category_index
    redirect_to category_index_seo_path(search_params)
  end

  def category_index_seo
    @articles = Article.search(category_params)
  end

  def show
  end

  def search
    redirect_to search_seo_friendly_path(search_params)
  end

  def search_seo_friendly
    @articles = Article.search params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end

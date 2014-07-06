class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  include ParamsExt

  def index
    @articles = Article.search(index_params)
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
end

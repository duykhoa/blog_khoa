class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  include ParamsExt

  def index
    @articles = Article.search
  end

  def show
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

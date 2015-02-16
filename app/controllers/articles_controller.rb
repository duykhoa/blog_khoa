class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  include ParamsExt

  def index
    @articles = Article.search nil, page_param
  end

  def show
  end

  def search
    @articles = Article.search(:all, category_params)
    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def page_param
      params.permit :page
    end
end

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :set_comments, only: [:show]

  include ParamsExt

  def index
    @articles = Article.search
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_comments
      @comments = @article.comments
    end
end

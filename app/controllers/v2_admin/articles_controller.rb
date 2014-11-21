class V2Admin::ArticlesController < V2Admin::HomesController

  before_action :set_article, only: [:show, :edit, :destroy]

  include ParamsExt

  def index
    @articles = Article.search(index_params(params))
  end

  def destroy
    status = @article.destroy ? { success: true, action: :destroy } : { success: false, action: destroy }

    redirect_to v2_admin_articles_path, flash: status
  end

  private

  def set_article
    @article = Article.find article_param[:id]
  end

  def article_param
    params.permit :id
  end
end

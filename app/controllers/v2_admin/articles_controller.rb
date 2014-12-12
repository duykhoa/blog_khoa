class V2Admin::ArticlesController < V2Admin::HomesController

  before_action :set_article, only: [:show, :edit, :destroy, :update]

  include ParamsExt

  def index
    sleep 1 #waiting Elastic update index
    @articles = Article.search(:all, index_params(params))
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    @article.create_or_update_with_commit_type(commit_type_param[:commit])

    redirect_to v2_admin_articles_path
  end

  def edit
  end

  def update
    @article.update(article_params)

    @article.create_or_update_with_commit_type(commit_type_param[:commit])

    redirect_to v2_admin_articles_path
  end

  def destroy
    status = @article.destroy ? { success: true, action: :destroy } : { success: false, action: :destroy }

    redirect_to v2_admin_articles_path, flash: status
  end

  private

  def set_article
    @article = Article.find article_id_param[:id]
  end

  def article_id_param
    params.permit :id
  end

  def article_params
    params.require(:article).permit(:title, :content, :category_id, :feature_image, :short_content)
  end

  def commit_type_param
    params.require(:article).permit :commit
  end
end

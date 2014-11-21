class V2Admin::ArticlesController < V2Admin::HomesController

  def index
    @articles = Article.search
  end
end

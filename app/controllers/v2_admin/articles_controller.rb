class V2Admin::ArticlesController < V2Admin::HomesController

  include ParamsExt

  def index
    @articles = Article.search(index_params(params))
  end
end

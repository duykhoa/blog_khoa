class V2Admin::CategoriesController < V2Admin::HomesController
  layout "admin"

  def index
    @categories = Category.all
  end

  def create
  end

  def update
  end
end

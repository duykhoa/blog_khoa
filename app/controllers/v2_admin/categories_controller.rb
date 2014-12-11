class V2Admin::CategoriesController < V2Admin::HomesController
  layout "admin"

  def index
    @categories = Category.all
  end

  def create
    Category.update_or_create(category_list_params)
  end

  private

  def category_list_params
    params.require(:category_list)
  end
end

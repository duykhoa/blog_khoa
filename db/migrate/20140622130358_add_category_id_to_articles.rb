class AddCategoryIdToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :category
  end
end

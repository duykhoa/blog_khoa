class RemoveCategoryIdInArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :category_id
  end

  def down
    add_column :articles, :category_id, :integer
  end
end

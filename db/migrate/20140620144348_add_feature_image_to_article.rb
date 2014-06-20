class AddFeatureImageToArticle < ActiveRecord::Migration
  def up
    add_attachment :articles, :feature_image
  end

  def down
    remove_attachment :articles, :feature_image
  end
end

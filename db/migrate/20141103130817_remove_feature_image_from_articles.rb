class RemoveFeatureImageFromArticles < ActiveRecord::Migration
  def up
    remove_attachment :articles, :feature_image
  end
end

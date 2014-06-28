class RemoveKeyFromBlogSeos < ActiveRecord::Migration
  def change
    remove_column :blog_seos, :key
  end
end

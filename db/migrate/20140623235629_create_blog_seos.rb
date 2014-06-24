class CreateBlogSeos < ActiveRecord::Migration
  def change
    create_table :blog_seos do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end

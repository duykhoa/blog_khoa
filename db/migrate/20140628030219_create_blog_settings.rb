class CreateBlogSettings < ActiveRecord::Migration
  def change
    create_table :blog_settings do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end

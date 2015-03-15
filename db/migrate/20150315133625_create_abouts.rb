class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :content

      t.timestamps
    end
  end
end

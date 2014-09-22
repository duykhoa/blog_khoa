class AddShortContentToAboutMes < ActiveRecord::Migration
  def change
    add_column :about_mes, :short_content, :string
  end
end

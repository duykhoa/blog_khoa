class ChangeShortContentDataTypeInAboutMes < ActiveRecord::Migration
  def up
    change_column :about_mes, :short_content, :text
  end

  def down
    change_column :about_mes, :short_content, :string
  end
end

class ChangeContentFieldDataTypeToText < ActiveRecord::Migration
  def up
    change_column :abouts, :content, :text
  end
end

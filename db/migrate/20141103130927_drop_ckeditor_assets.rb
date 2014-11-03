class DropCkeditorAssets < ActiveRecord::Migration
  def up
    drop_table :ckeditor_assets
  end
end

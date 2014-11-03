class DropAboutMes < ActiveRecord::Migration
  def up
    drop_table :about_mes
  end
end

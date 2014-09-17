class AddAvatarToAboutMes < ActiveRecord::Migration
  def self.up
    add_attachment :about_mes, :avatar
  end

  def self.down
    remove_attachment :about_mes, :avatar
  end
end

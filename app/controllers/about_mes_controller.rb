class AboutMesController < ApplicationController
  def index
    @about_me = AboutMe.first
    render File.join(view_path, controller_name, 'index')
  end
end

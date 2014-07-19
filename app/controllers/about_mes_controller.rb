class AboutMesController < ApplicationController
  def index
    @about_me = AboutMe.first
    render custom_path_for
  end
end

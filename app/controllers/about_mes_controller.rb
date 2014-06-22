class AboutMesController < ApplicationController
  def index
    @about_mes = AboutMe.first
  end
end

class AboutMesController < ApplicationController
  def index
    @about_me = AboutMe.first
  end
end

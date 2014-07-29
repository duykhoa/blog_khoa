class AboutMesController < ApplicationController
  layout 'application'
  def index
    @about_me = AboutMe.first
  end
end

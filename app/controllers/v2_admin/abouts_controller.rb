class V2Admin::AboutsController < ApplicationController
  layout 'admin'

  before_action :set_about

  def show
  end

  def edit
  end

  def update
    @about.update(about_params)
    redirect_to v2_admin_about_path(@about)
  end

  private

  def set_about
    @about = About.first
  end

  def about_params
    params.require(:about).permit(:description, :avatar)
  end
end

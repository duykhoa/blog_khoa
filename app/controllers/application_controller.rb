class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout "themes/#{BlogSetting.theme}/layouts/application"

  protect_from_forgery with: :exception
  before_action :get_categories

  def view_path
    File.join('themes', BlogSetting.theme)
  end

  private
  def get_categories
    @categories = Category.all_category_name
  end

  helper_method :view_path
end

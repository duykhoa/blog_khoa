class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :get_categories

  layout :theme_layout

  protected
  def theme_layout
    File.join(view_path, 'layouts/application')
  end

  def view_path
    ['themes', BlogSetting.theme]
  end

  def get_categories
    @categories = Category.all_category_name
  end

  def custom_path_for(action = 'index')
    File.join(view_path, controller_name, action)
  end

  helper_method :view_path
end

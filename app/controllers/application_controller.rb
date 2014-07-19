class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :get_categories

  layout :theme_layout

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

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

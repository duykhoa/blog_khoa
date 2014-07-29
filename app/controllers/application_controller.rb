class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :get_categories
  theme  BlogSetting.theme
  layout 'application'

  #rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  #rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: File.join(view_path, "errors/error_#{status}"), layout: File.join(view_path, 'layouts/application'), status: status }
      format.all { render nothing: true, status: status }
    end
  end

  protected
  def get_categories
    @categories = Category.all_category_name
  end
end

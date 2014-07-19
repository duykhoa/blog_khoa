class ErrorsController < ApplicationController
  def error_404
    render custom_path_for('error_404')
  end

  def error_500
    render custom_path_for('error_500')
  end
end

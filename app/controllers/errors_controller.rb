class ErrorsController < ApplicationController
  def error_404
    render 'error_404'
  end

  def error_500
    render 'error_500'
  end
end

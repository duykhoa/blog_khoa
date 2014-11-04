class CommentsController < ApplicationController
  def create
    render json: {status: :success}
  end
end

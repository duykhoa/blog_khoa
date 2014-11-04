class CommentsController < ApplicationController
  before_action :comment_params

  def create
    comment = Comment.new(comment_params)
    comment.save

    render json: {status: :success}
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type)
  end
end

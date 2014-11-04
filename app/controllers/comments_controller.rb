class CommentsController < ApplicationController
  before_action :comment_params
  before_action :set_article

  def create
    comment = Comment.new(comment_params)
    comment.save

    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type, :user_id)
  end

  def set_article
    @article = Article.find params.fetch(:comment).fetch(:commentable_id)
  end
end

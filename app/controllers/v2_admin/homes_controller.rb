class V2Admin::HomesController < ApplicationController
  before_filter :authenticate_user!
  before_action :statistic_data

  layout 'admin'

  def index
    render 'index'
  end

  private

  def statistic_data
    @posts_count = Article.search(:all).count
    @publish_posts_count = Article.search.count
    @subscribers = EmailSubscribe.count
    @last_post = Article.last
  end
end

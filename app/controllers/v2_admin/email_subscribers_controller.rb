class V2Admin::EmailSubscribersController < ApplicationController
  layout 'admin'

  def index
    @email_subscribers = EmailSubscribe.page(page_params[:page])
  end

  private

  def page_params
    params.permit(:page)
  end
end

class EmailSubscribesController < ApplicationController
  def create
    @email_subscribe = EmailSubscribe.new(email_subscribe_params)

    if @email_subscribe.save
      render json: { success: true }
    else
      render json: { success: false, error_trace: @email_subscribe.errors.messages }
    end
  end

  private

  def email_subscribe_params
    params.require(:email_subscribe).permit(:email)
  end
end

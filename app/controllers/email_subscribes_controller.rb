class EmailSubscribesController < ApplicationController
  def create
    @email_subscribe = EmailSubscribe.new(email_subscribe_params)

    respond_to do |format|
      if @email_subscribe.save
        format.json { render json: {success: true } }
      else
        format.json { render json: {success: false, error_trace: @email_subscribe.errors.messages} }
      end
    end
  end

  private

  def email_subscribe_params
    params.require(:email_subscribe).permit(:email)
  end
end

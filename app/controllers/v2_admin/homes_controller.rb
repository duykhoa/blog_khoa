class V2Admin::HomesController < ApplicationController
  before_filter :authenticate_user!

  layout 'admin'

  def index
    render 'index'
  end
end

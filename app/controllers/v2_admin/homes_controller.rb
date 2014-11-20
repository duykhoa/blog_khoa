class V2Admin::HomesController < ApplicationController
  layout 'admin'

  def index
    render 'index'
  end
end

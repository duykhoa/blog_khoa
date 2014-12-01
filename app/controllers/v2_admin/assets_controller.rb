class V2Admin::AssetsController < ApplicationController
  before_action :set_uploader

  def create
    path = @uploader.upload(File.open(path_param))

    render json: { path: path }
  end

  private

  def path_param
    params.permit(:path)
  end

  def set_uploader
    @uploader = DropboxUploader.new
  end
end

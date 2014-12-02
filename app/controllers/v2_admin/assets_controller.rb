class V2Admin::AssetsController < ApplicationController
  before_action :set_uploader

  def create
    path = @uploader.upload(upload_file, file_name)

    render json: { path: path }
  end

  private

  def file_name
    path_param[:path].original_filename
  end

  def upload_file
    path_param[:path].tempfile
  end

  def path_param
    params.permit(:path)
  end

  def set_uploader
    @uploader = DropboxUploader.new
  end
end

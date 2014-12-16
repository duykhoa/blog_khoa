Dropbox::API::Config.app_key    =  Settings.dropbox.app_key
Dropbox::API::Config.app_secret =  Settings.dropbox.app_secret

require "#{Rails.root}/lib/dropbox_uploader/raw_link"

class DropboxUploader

  include DropboxUpload::RawLink

  def initialize
    @uploader = Dropbox::API::Client.new(token: Settings.dropbox.access_token, secret: Settings.dropbox.access_secret)
  end

  def path(filename)
    BlogSetting.blog_title + "/" + SecureRandom.hex(20) + filename
  end

  def upload(file, filename)
    raise "NotAFile" unless file.is_a?(File) || file.is_a?(Tempfile)

    raw_file_link(@uploader.chunked_upload(path(filename), file).share_url.url) rescue nil
  end
end

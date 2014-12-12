Dropbox::API::Config.app_key    =  Settings.dropbox.app_key
Dropbox::API::Config.app_secret =  Settings.dropbox.app_secret

class DropboxUploader
  #Dropbox::API::Client.new(token: Settings.dropbox.access_token, secret: Settings.dropbox.access_secret)

  def initialize
    @uploader = Dropbox::API::Client.new(token: Settings.dropbox.access_token, secret: Settings.dropbox.access_secret)
  end

  def upload(file, filename)
    raise "NotAFile" unless file.is_a?(File) || file.is_a?(Tempfile)

    @uploader.chunked_upload(SecureRandom.hex(20) + filename, file).direct_url.url rescue nil
  end
end

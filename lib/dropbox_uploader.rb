class DropboxUploader
  #Dropbox::API::Client.new(token: Settings.dropbox.access_token, secret: Settings.dropbox.access_secret)

  def initialize
    @uploader = Dropbox::API::Client.new(token: Settings.dropbox.access_token, secret: Settings.dropbox.access_secret)
  end

  def upload(file)
    raise "NotAFile" unless file.is_a?(File)

    @uploader.chunked_upload(SecureRandom.hex(20), file).direct_url.url rescue nil
  end
end

Dropbox::API::Config.app_key    =  Settings.dropbox.app_key
Dropbox::API::Config.app_secret =  Settings.dropbox.app_secret

DROPBOX_UPLOADER = Dropbox::API::Client.new(token: Settings.dropbox.access_token, secret: Settings.dropbox.access_secret)

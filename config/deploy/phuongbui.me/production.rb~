set :deploy_to, Settings.deploy_path
set :rails_env, :production
server Settings.server_ip, user: Settings.deploy_user, roles: %w{web app db}
set :rvm_custom_path, '/usr/local/rvm'  # only needed if not detected


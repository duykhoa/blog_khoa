set :application, 'samle_blog'
set :rvm_custom_path, '/usr/local/rvm'  # only needed if not detected
set :deploy_to, '/home/deployer/path/to/app'
set :rails_env, :production
set :branch, 'v2.2'
server 'deploy.com', user: 'deployer', roles: %w{web app db}

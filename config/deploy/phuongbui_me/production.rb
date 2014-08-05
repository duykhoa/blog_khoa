set :rvm_custom_path, '/usr/local/rvm'  # only needed if not detected
set :deploy_to, '/home/deploy/blog_khoa/'
set :rails_env, :production
server '128.199.137.128', user: 'deploy', roles: %w{web app db}

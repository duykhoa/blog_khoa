set :deploy_to, '/home/deploy/blog_khoa_trantat.com/'
set :rails_env, :production
server '128.199.137.128', deploy, roles: %w{web app db}
set :rvm_custom_path, '/usr/local/rvm'  # only needed if not detected


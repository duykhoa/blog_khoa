# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'blog_khoa'
set :repo_url, 'git@bitbucket.org:duykhoa_tran/blog_khoa.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/blog_khoa/'

set :branch, ENV['BRANCH'] || "master"

set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p451'      # Defaults to: 'default'
set :rvm_custom_path, '/home/ubuntu/.rvm'  # only needed if not detected
set :deploy_via, :copy
set :migration_role, 'migrator'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
       execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :migrate_db do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:migrate'
        end
      end
    end
  end

  after :publishing, :migrate_db, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
       within release_path do
         execute :rake, 'cache:clear'
       end
    end
  end

end

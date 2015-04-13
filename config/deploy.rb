# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'huongvinh4me'
set :repo_url, 'git@github.com:duykhoa/blog_khoa.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
#set :deploy_to, '/home/blog_khoa/'

set :branch, ENV['BRANCH'] || "v2.0_huongvinh4me"

set :rvm_type, :system
set :rvm_ruby_version, '2.0.0-p451'      # Defaults to: 'default'

set :use_sudo, true

set :deploy_via, :copy
set :migration_role, 'migrator'
#set :default_shell, '/bin/bash -l'
#set :default_environment, {
  #'PATH' => "/opt/ruby-enterprise/bin/:$PATH"
#}

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

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
    on roles(:app) do
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

  task :seed_data do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  task :elasticsearch_index do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'environment tire:import CLASS=Article FORCE=true'
        end
      end
    end
  end

  task :update_sym_link do
    on roles(:app) do
      execute "rm -rf #{release_path}/public/ckeditor_assets"
      execute "rm -rf #{release_path}/public/system"

      execute "ln -nfs #{shared_path}/ckeditor_assets #{release_path}/public/ckeditor_assets"
      execute "ln -nfs #{shared_path}/system #{release_path}/public/system"
      execute "ln -nfs #{shared_path}/sitemaps #{release_path}/public/sitemaps"
      execute "ln -nfs #{shared_path}/sitemaps/sitemap.xml #{release_path}/public/sitemap.xml"
      execute "ln -nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
      execute "ln -nfs #{shared_path}/favicon.ico #{release_path}/public/favicon.ico"
    end
  end

  task :sitemap do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'sitemap:generate'
        end
      end
    end
  end

  task :ckeditor_assets_compile do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ckeditor:create_nondigest_assets'
        end
      end
    end
  end

  before :updated, :update_sym_link
  after :finishing, :migrate_db
  #after :finishing, :sitemap
  after :finishing, :restart
end

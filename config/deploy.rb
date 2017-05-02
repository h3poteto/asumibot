# config valid only for current version of Capistrano
lock '3.4.0'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


set :application, 'asumibot'
set :repo_url, 'git@github.com:h3poteto/asumibot'
set :branch, 'terraform'
set :deploy_to, '/srv/www/asumibot'
set :scm, :git
set :log_level, :debug
set :pty, false

set :rbenv_path, '~/.rbenv'
set :rbenv_type, :system
set :rbenv_ruby, '2.3.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :linked_dirs, %w{log tmp/backup tmp/pids tmp/sockets vendor/bundle}
set :linked_files, %w{config/settings/production.local.yml}
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn.rb"
set :keep_releases, 5
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

after 'deploy:publishing', 'deploy:restart'
after "deploy:restart", 'monitor:stop_stream'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Upload local config yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config/settings"
      end
      upload!('config/settings/production.local.yml', "#{shared_path}/config/settings/production.local.yml")
    end
  end

  namespace :shoryuken do
    task :stop do
      on roles(:app) do |host|
        execute "cd #{shared_path}; if [ -f tmp/pids/shoryuken.pid ] && ps $(cat tmp/pids/shoryuken.pid) ; then kill -15 $(cat tmp/pids/shoryuken.pid); fi"
      end
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
  after :restart, 'deploy:shoryuken:stop'
end

# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.11.0'

require 'dotenv'
Dotenv.load

set :application, ENV['DEPLOY_HOST']
set :repo_url, 'git@github.com:mjacobus/predios.git'
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, "/var/www/apps/#{fetch(:application)}"
set :chruby_ruby, 'ruby-2.4.0'
set :pty, true
set :keep_releases, 10
set :bundle_flags, '--deployment'

set :whenever_environment, -> { fetch(:stage) }
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

append :linked_files,
  '.env'

append :linked_dirs,
  'bkp',
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'public/system'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Warmup application by making a curl request'
  task :warmup do
    on roles(:app), in: :sequence, wait: 5 do
      within(release_path) do
        execute :curl, "#{fetch(:application)}/", '>', 'tmp/warmpu.txt'
      end
    end
  end

  # before 'deploy:compile_assets', :yarn_build
  after :publishing, :restart
  after :restart, :warmup
end

namespace :logs do
  desc 'show log files'
  task :show do
    on roles(:app), in: :sequence, wait: 5 do
      execute :tail, '-f', shared_path.join('*log'), '/var/log/nginx/*log'
    end
  end
end

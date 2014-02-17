require 'bundler/capistrano'
set :domain, 'labpress.com.ar'
set :applicationdir, "/opt/prj/agregador"
set :scm, 'git'
set :repository,  "git@bitbucket.org:ibmedialab/noticioso.git"
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :scm_verbose, true
set :port, 10022
set :keep_releases, 3


# roles (servers)
server "labpress.com.ar", :app, :web, :db, :primary => true

# deploy config
set :deploy_to, applicationdir
#set :git_shallow_clone, 1



# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
ssh_options[:forward_agent] = true
ssh_options[:keys] = %w('~/.ssh/id_rsa.pub')

# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :migrate do
	desc "Migrar DB"
	task :start do
		run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
	end
end

after "deploy", "deploy:update_code"
after "deploy:update", "deploy:update_code"
after "deploy:update_code", "deploy:finalize_update"
after "deploy:finalize_update", "bundle:install"
after "bundle:install", "deploy:create_symlink"
after "deploy:create_symlink", "migrate:start"
after 'migrate:start', 'deploy:restart'
after "deploy:restart", "deploy:cleanup"
after "deploy:cleanup", "nginx:restart"

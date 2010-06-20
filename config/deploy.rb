require 'vendor/plugins/thinking-sphinx/recipes/thinking_sphinx'

set :application, 'inherit'

set :user, 'root'
set :hosting, 'webbynode'
set :env, 'production'
set :deploy_to, "/var/rails/inherit_deploy"
role :web, 'inherit.iwakela.com'
role :app, 'inherit.iwakela.com'
role :db, 'inherit.iwakela.com', :primary => true

default_run_options[:pty] = true

set :repository,  "git@github.com:ilake/inherit.git"
set :scm, "git"
set :git_account, 'ilake'
set :scm_passphrase, "plokmiju" #This is your custom users password

set :branch, "master"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :use_sudo, false

set :shared_children, %w(system log pids mugshots tiny_mce_photos)
set :online_configs, %w(database app_config cucumber tiny_mce sphinx)

after 'deploy:symlink',  'inherit:extra_setting'

namespace :inherit do 
  task :setup do
    deploy::setup
    thinking_sphinx.install.sphinx
    update #algonet update
    deploy::check
    #deploy::cold   #first time initialize
    thinking_sphinx.shared_sphinx_folder
    gem_install
    run "cd #{current_path} && #{sudo} rake RAILS_ENV=production db:create"
  end

  task :extra_setting do
    online_configs.each do |config|
      online_config = "#{latest_release}/config/#{config}.yml.online"
      run "cp #{online_config} #{latest_release}/config/#{config}.yml;"
    end
  end

  task :gem_install do
    run "cd #{current_path} && #{sudo} rake RAILS_ENV=production gems:install"
  end

  task :chown do
    run "cd #{latest_release} && chown www-data #{latest_release} -R;"
    run "cd #{shared_path} && chown www-data #{shared_path} -R;"
  end

  task :update do 
    deploy::update
  end

  task :update_crontab, :roles => :db do
    run "cd #{current_path} && /opt/ruby-enterprise/bin/whenever --update-crontab #{application}"
  end

  task :sphinx_stop, :roles => [:app] do
    thinking_sphinx.stop
  end

  task :sphinx_start, :roles => [:app] do
    symlink_sphinx_indexes
    thinking_sphinx.configure
    thinking_sphinx.start
  end

  task :symlink_sphinx_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{current_path}/db/sphinx"
  end

  task :start do 
    deploy::migrate
    chown if hosting == 'webbynode'
    restart
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :check_path, :roles => :db do
    run "echo $PATH"
  end

  task :fp_symlink, :roles => [:app] do
    run "cd #{current_path} && rake asset_fingerprint:symlinks:generate RAILS_ENV=#{env}"
  end

  task :checkout_public, :roles => [:app] do
    run "cd #{current_path} && git checkout public/"
  end

  task :deploy_all do 
    delayed_job::stop
    sphinx_stop
    update
    gem_install
    sphinx_start
    start
    delayed_job::start
    update_crontab
    fp_symlink
    checkout_public
    chown if hosting == 'webbynode'
  end

end

namespace :delayed_job do
  desc "Start delayed_job process" 
  task :start, :roles => :app do
    run "cd #{current_path}; ruby script/delayed_job start -- #{env}" 
  end

  desc "Stop delayed_job process" 
  task :stop, :roles => :app do
    run "cd #{current_path}; script/delayed_job stop -- #{env}" 
  end

  desc "Restart delayed_job process" 
  task :restart, :roles => :app do
    run "cd #{current_path}; script/delayed_job restart -- #{env}" 
  end
end

# Please install the Engine Yard Capistrano gem
# gem install eycap --source http://gems.engineyard.com
require "eycap/recipes"

set :keep_releases, 5
set :application,   'timesarrow'
set :repository,    'git://github.com/kristenhazard/timesarrow.git'
set :deploy_to,     "/data/#{application}"
set :deploy_via,    :export
set :monit_group,   "#{application}"
set :scm,           :git
set :git_enable_submodules, 1
# This is the same database name for all environments
set :production_database,'timesarrow_production'

set :environment_host, 'localhost'
set :deploy_via, :remote_cache

# uncomment the following to have a database backup done before every migration
# before "deploy:migrate", "db:dump"

# comment out if it gives you trouble. newest net/ssh needs this set.
ssh_options[:paranoid] = false
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
default_run_options[:pty] = true # required for svn+ssh:// andf git:// sometimes

# This will execute the Git revision parsing on the *remote* server rather than locally
set :real_revision, 			lambda { source.query_revision(revision) { |cmd| capture(cmd) } }


task :production do
  role :web, '174.129.0.212'
  role :app, '174.129.0.212'
  role :db, '174.129.0.212', :primary => true
  set :environment_database, Proc.new { production_database }
  set :dbuser,        'deploy'
  set :dbpass,        'g3AELBas8D'
  set :user,          'deploy'
  set :password,      'g3AELBas8D'
  set :runner,        'deploy'
  set :rails_env,     'production'
end


task :staging do
  role :web, '174.129.2.113'
  role :app, '174.129.2.113'
  role :db, '174.129.2.113', :primary => true
  set :environment_database, Proc.new { production_database }
  set :dbuser,        'deploy'
  set :dbpass,        '7abpp31pKw'
  set :user,          'deploy'
  set :password,      '7abpp31pKw'
  set :runner,        'deploy'
  set :rails_env,     'staging'
end


# TASKS
# Don't change unless you know what you are doing!

after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"
after "deploy:update_code","deploy:symlink_configs"

namespace :nginx do
  task :start, :roles => :app do
    sudo "nohup /etc/init.d/nginx start > /dev/null"
  end

  task :restart, :roles => :app do
    sudo "nohup /etc/init.d/nginx restart > /dev/null"
  end
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
 
  task :stop, :roles => :app do
    # Do nothing.
  end
 
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'

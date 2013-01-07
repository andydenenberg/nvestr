set :application, "stc"
set :repository,  "git@github.com:andydenenberg/stc.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "stc.ospreypointcap.com"                          # Your HTTP server, Apache/etc
role :app, "stc.ospreypointcap.com"                          # This may be the same as your `Web` server
role :db,  "stc.ospreypointcap.com", :primary => true # This is where Rails migrations will run
role :db,  "stc.ospreypointcap.com"

set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/rails/#{application}"
set :keep_releases, 5

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
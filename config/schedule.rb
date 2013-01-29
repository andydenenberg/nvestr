# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# Learn more: http://github.com/javan/whenever

# * * * * * ls >> /var/logs/my_app.log

# THE Following works like a champ...

# 0 15 * * * /bin/bash -l -c 'cd ~/rails/nvestr && RAILS_ENV=production bundle exec rake demo:daily_snapshot'


set :output, { :standard => "/var/logs/my_app.log", :error => "/var/logs/my_err.log" }
  
 every 1.minute do
   rake "demo:daily_snapshot"
 end

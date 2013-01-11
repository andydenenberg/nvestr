namespace :family do
  desc "Setup Family Members"
  task :setup => :environment do

user = User.create! :name => 'Roberta', :email => 'roberta@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie02'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Mike', :email => 'mike@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie02'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Tim', :email => 'tim@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie02'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Nerissa', :email => 'nerissa@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie02'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Gina', :email => 'gina@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie02'
puts 'New user created: ' << user.name
user.add_role :admin

  end
  
end

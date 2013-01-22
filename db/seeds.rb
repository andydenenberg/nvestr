# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'CREATING ROLES'
Role.create([
  { :name => 'admin' }, 
  { :name => 'user' }, 
  { :name => 'VIP' }
], :without_protection => true)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Andy', :email => 'andy@denenberg.net', :password => 'xxxxxx', :password_confirmation => 'xxxxxx'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Roberta', :email => 'roberta@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Mike', :email => 'mike@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Tim', :email => 'tim@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Nerissa', :email => 'nerissa@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie'
puts 'New user created: ' << user.name
user.add_role :admin
user = User.create! :name => 'Gina', :email => 'gina@denenberg.net', :password => 'minnie', :password_confirmation => 'minnie'
puts 'New user created: ' << user.name
user.add_role :admin
class UserMailer < ActionMailer::Base
  if ENV['PLATFORM'] == 'Heroku'
    default :from => "app13473659@heroku.com"
  else
    default :from => "andy@denenberg.net"
  end
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Welcome to our Colaboration!")
  end
end
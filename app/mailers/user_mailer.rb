class UserMailer < ActionMailer::Base
  default :from => "app2014218@heroku.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Welcome to our Colaboration!")
  end
end
class UserMailer < ActionMailer::Base
  default :from => "app13473659@heroku.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Welcome to our Colaboration!")
  end
end
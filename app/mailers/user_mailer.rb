class UserMailer < ActionMailer::Base
  default :from => "andydenenberg@gmail.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Welcome to our Colaboration!")
  end
end
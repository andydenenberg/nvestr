# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'XXX'
    email 'xxx@denenberg.net'
    password 'xxxxxx'
    password_confirmation 'xxxxxx'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
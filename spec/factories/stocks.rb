# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock do
    user nil
    symbol "MyString"
    purch_price "9.99"
    purch_date "2013-01-09"
    portfolio "MyString"
  end
end

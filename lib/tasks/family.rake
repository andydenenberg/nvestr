namespace :family do
  desc "Setup Family Members"
  task :setup => :environment do

User.all.each do |user| 
  p = Portfolio.create!( :name => 'Family Fun', :user_id => user.id, :cash => 100000 )
  puts 'New portfolio created: ' + p.name + ' for ' + p.user_id.to_s
end
  
introduction = Post.create! :title => 'Welcome to our Family Portfolio Competition',
:body => "<br>At the first of the year everyone started with $100,000 cash.<br><br>
On January 3, each family member's portfolio added a $10,000 position of their favorite stock.
Therefore there is approximately $90,000 of uninvested cash available to purchase more stocks. <br><br>
You cannot purchase more than your cash balance can afford, but you can sell a stock and the proceeds add to your cash balance to be reinvested. <br><br>
Please manage your Family Favorite portfolio and you can also create additional portfolios to test your ideas...<br><br>
<h4>Good Luck!</h4>
PS - If using a phone browser or IPad you are automatically sent to the mobile site - click on 'Full Site' in footer to override this.<br><br>",
:type_is => 'Discussion',
:user_id => User.find_by_email('andy@denenberg.net')


user = User.find_by_email('andy@denenberg.net')
shares = (10000 / 88.55).to_i
stock = {"symbol"=>"xom",
          "name"=>"Exxon Mobil Corporation",
          "purch_price"=>"88.55",
          "quantity"=> shares,
          "purch_date"=>"2013-01-03",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"Exxon trades at a low PE and has a reasonable dividend of 2.5%.
              Its dividend payout ratio is less than 25% which means its has plenty of reserve profit to keep increasing
               its dividend.  The world's energy needs are ever increasing which is good for XOM's future profits.",
                "user_id"=>user}}
          }
Stock.add_position ( stock )

user = User.find_by_email('roberta@denenberg.net')
shares = (10000 / 44.71).to_i
stock = {"symbol"=>"ltd",
          "name"=>"Limited Brands, Inc.",
          "purch_price"=>"44.71",
          "quantity"=> shares,
          "purch_date"=>"2013-01-03",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"please update",
                "user_id"=>user}}
          }
Stock.add_position ( stock )

user = User.find_by_email('mike@denenberg.net')
shares = (10000 / 36.93).to_i
stock = {"symbol"=>"dish",
          "name"=>"Dish Network Corp.",
          "purch_price"=>"36.93",
          "quantity"=> shares,
          "purch_date"=>"2013-01-03",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"please update",
                "user_id"=>user}}
          }
Stock.add_position ( stock )

user = User.find_by_email('tim@denenberg.net')
shares = (10000 / 34.77).to_i
stock = {"symbol"=>"tsla",
          "name"=>"Tesla Motors, Inc.",
          "purch_price"=>"34.77",
          "quantity"=> shares,
          "purch_date"=>"2013-01-03",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"Tesla is working towards the goal of releasing their new four door sedan,
             the Model S, which I believe will propel the company into finally making money.
               They recently won a lawsuit against massachusetts state automobile dealers association which would have prevented
                them from selling cars out of their stores and online.
              With this lawsuit behind them, Tesla is set to start selling the model S.",
                "user_id"=>user}}
          }
Stock.add_position ( stock )

user = User.find_by_email('tim@denenberg.net')
shares = (10000 / 15.92).to_i
stock = {"symbol"=>"scty",
          "name"=>"SolarCity Corporation",
          "purch_price"=>"15.92",
          "quantity"=> shares,
          "purch_date"=>"2013-01-18",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"Solar City is a full service home solar and electric installation service company.
              They're ipo was a few months ago...",
                "user_id"=>user}}
          }
Stock.add_position ( stock )

user = User.find_by_email('nerissa@denenberg.net')
shares = (10000 / 723.67).to_i
stock = {"symbol"=>"goog",
          "name"=>"Google Inc.",
          "purch_price"=>"723.67",
          "quantity"=> shares,
          "purch_date"=>"2013-01-03",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"Please update",
                "user_id"=>user}}
          }
Stock.add_position ( stock )

user = User.find_by_email('gina@denenberg.net')
shares = (10000 / 51.21).to_i
stock = {"symbol"=>"dis",
          "name"=>"The Walt Disney Company",
          "purch_price"=>"51.21",
          "quantity"=> shares,
          "purch_date"=>"2013-01-03",
          "portfolio_id"=>Portfolio.where(:user_id => user.id, :name => 'Family Fun').first.id ,
          "user_id"=>user,
          "comments_attributes"=>{"0"=>{"note"=>"Please update",
                "user_id"=>user}}
          }
Stock.add_position ( stock )


def stock(size,symbol,price,date,user,comment, portfolio)
  s = {"symbol"=> symbol,
            "purch_price"=> price,
            "quantity"=> (size / price).to_i,
            "purch_date"=> date,
            "portfolio_id"=> portfolio.id ,
            "user_id"=>user,
            "comments_attributes"=>{"0"=>{"note"=> comment,
                  "user_id"=>user}}
            }
  return s
end

portfolio = Portfolio.create!( :name => 'YCharts', :user_id => 1, :cash => 100000 )
puts 'New portfolio created: ' + portfolio.name + ' for ' + portfolio.user_id.to_s
size = 10000
user = User.find_by_email('andy@denenberg.net')

pos = stock(size, "mhk", 93.30, "2013-01-08", user, "Mentioned by Zacks as a good stock to follow the resurgence in housing.", portfolio )
Stock.add_position ( pos )

pos = stock(size, "wag", 38.17, "2013-01-08", user, "See Ycharts article", portfolio  )
Stock.add_position ( pos )

pos = stock(size, "itw", 62.22, "2013-01-08", user, "Mentioned by Zacks as a good stock for the recovery in Housing", portfolio  )
Stock.add_position ( pos )

pos = stock(size, "cvx", 111.73, "2013-01-11", user, "chevron stock cheaper than exxons also better exposed to higher brent crude prices", portfolio  )
Stock.add_position ( pos )

pos = stock(size, "rds-a", 69.61, "2013-01-11", user, "Recommended by YCharts", portfolio  )
Stock.add_position ( pos )

pos = stock(size, "qcom", 64.9, "2013-01-11", user, "as  goes apple so goes qualcomm think again", portfolio  )
Stock.add_position ( pos )

pos = stock(size, "shw", 161.28, "2013-01-11", user, "sherwin williams up 70 in a year more room to run", portfolio  )
Stock.add_position ( pos )

pos = stock(size, "wfc", 34.77, "2013-01-11", user, "Everyone likes it...?", portfolio  )
Stock.add_position ( pos )

#ko, jnj, vf, afl, wmt

end
  
end

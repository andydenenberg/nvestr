
namespace :family do
  
desc 'Build the Databases'
task :setup => ["db:drop", "db:create", "db:migrate", "db:seed", "build_db"]

desc "Setup Family Members"
task :build_db => :environment do
  
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


def purch(size,symbol,price,date,user,comment, portfolio)
  s = {"symbol"=> symbol,
            "purch_price"=> price,
            "quantity"=> size,
            "purch_date"=> date,
            "portfolio_id"=> portfolio.id ,
            "user_id"=>user,
            "comments_attributes"=>{"0"=>{"note"=> comment,
                  "user_id"=>user}}
            }
  return s
end


desc "Setup SLAT"
task :create_SLAT => :environment do

  positions = [{"Symbol"=>"ATMI", "Name"=>"A T M I INC", "Quantity"=>"2,200", "Price"=>"$22.00", "Change"=>"$0.11", "Market Value"=>"$48400.00", "Day Change($)"=>"$242.00", "Day Change(%)"=>"0.50%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.92%", "Security Type"=>"Equity"}, {"Symbol"=>"ACE", "Name"=>"ACE LIMITED NEW F", "Quantity"=>"1,674", "Price"=>"$86.69", "Change"=>"$0.54", "Market Value"=>"$145119.06", "Day Change($)"=>"$903.96", "Day Change(%)"=>"0.63%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.76%", "Security Type"=>"Equity"}, {"Symbol"=>"A", "Name"=>"AGILENT TECHNOLOGIES INC", "Quantity"=>"555", "Price"=>"$41.80", "Change"=>"$0.17", "Market Value"=>"$23199.00", "Day Change($)"=>"$94.35", "Day Change(%)"=>"0.41%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.44%", "Security Type"=>"Equity"}, {"Symbol"=>"APD", "Name"=>"AIR PROD & CHEMICALS INC", "Quantity"=>"900", "Price"=>"$86.09", "Change"=>"$0.42", "Market Value"=>"$77481.00", "Day Change($)"=>"$378.00", "Day Change(%)"=>"0.49%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.47%", "Security Type"=>"Equity"}, {"Symbol"=>"AAPL", "Name"=>"APPLE INC", "Quantity"=>"20", "Price"=>"$450.81", "Change"=>"$4.75", "Market Value"=>"$9016.20", "Day Change($)"=>"$95.00", "Day Change(%)"=>"1.06%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.17%", "Security Type"=>"Equity"}, {"Symbol"=>"AMAT", "Name"=>"APPLIED MATERIALS INC", "Quantity"=>"552", "Price"=>"$13.57", "Change"=>"$0.32", "Market Value"=>"$7490.64", "Day Change($)"=>"$176.64", "Day Change(%)"=>"2.42%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.14%", "Security Type"=>"Equity"}, {"Symbol"=>"ADSK", "Name"=>"AUTODESK INC", "Quantity"=>"1,900", "Price"=>"$37.91", "Change"=>"-$0.06", "Market Value"=>"$72029.00", "Day Change($)"=>"-$114.00", "Day Change(%)"=>"-0.16%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.37%", "Security Type"=>"Equity"}, {"Symbol"=>"BASFY", "Name"=>"BASF SE ADR FSPONSORED ADR 1 ADR REPS 1 ORD", "Quantity"=>"810", "Price"=>"$98.56", "Change"=>"$2.26", "Market Value"=>"$79833.60", "Day Change($)"=>"$1830.60", "Day Change(%)"=>"2.35%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.52%", "Security Type"=>"Equity"}, {"Symbol"=>"BHP", "Name"=>"BHP BILLITON LTD ADR FSPONSORED ADR 1 ADR REP 2 ORD", "Quantity"=>"900", "Price"=>"$75.77", "Change"=>"$0.80", "Market Value"=>"$68193.00", "Day Change($)"=>"$720.00", "Day Change(%)"=>"1.07%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.30%", "Security Type"=>"Equity"}, {"Symbol"=>"CVS", "Name"=>"C V S CAREMARK CORP", "Quantity"=>"1,800", "Price"=>"$51.35", "Change"=>"-$0.51", "Market Value"=>"$92430.00", "Day Change($)"=>"-$918.00", "Day Change(%)"=>"-0.98%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.76%", "Security Type"=>"Equity"}, {"Symbol"=>"CCL", "Name"=>"CARNIVAL CORP NEW FPAIRED STK SPECIAL VTG TR", "Quantity"=>"900", "Price"=>"$34.99", "Change"=>"-$0.37", "Market Value"=>"$31491.00", "Day Change($)"=>"-$333.00", "Day Change(%)"=>"-1.05%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.60%", "Security Type"=>"Equity"}, {"Symbol"=>"CTL", "Name"=>"CENTURYLINK INC", "Quantity"=>"1,012", "Price"=>"$34.64", "Change"=>"$0.37", "Market Value"=>"$35055.68", "Day Change($)"=>"$374.44", "Day Change(%)"=>"1.08%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.67%", "Security Type"=>"Equity"}, {"Symbol"=>"CSCO", "Name"=>"CISCO SYSTEMS INC", "Quantity"=>"22,000", "Price"=>"$20.90", "Change"=>"$0.14", "Market Value"=>"$459800.00", "Day Change($)"=>"$3080.00", "Day Change(%)"=>"0.67%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"8.75%", "Security Type"=>"Equity"}, {"Symbol"=>"KO", "Name"=>"COCA COLA COMPANY", "Quantity"=>"3,735", "Price"=>"$38.52", "Change"=>"$0.81", "Market Value"=>"$143872.20", "Day Change($)"=>"$3025.35", "Day Change(%)"=>"2.15%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.74%", "Security Type"=>"Equity"},{"Symbol"=>"COP", "Name"=>"CONOCOPHILLIPS", "Quantity"=>"1,620", "Price"=>"$58.20", "Change"=>"$0.09", "Market Value"=>"$94284.00", "Day Change($)"=>"$145.80", "Day Change(%)"=>"0.15%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.79%", "Security Type"=>"Equity"}, {"Symbol"=>"DE", "Name"=>"DEERE & CO", "Quantity"=>"200", "Price"=>"$87.13", "Change"=>"$0.07", "Market Value"=>"$17426.00", "Day Change($)"=>"$14.00", "Day Change(%)"=>"0.08%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.33%", "Security Type"=>"Equity"}, {"Symbol"=>"DIS", "Name"=>"DISNEY WALT CO", "Quantity"=>"1,200", "Price"=>"$54.25", "Change"=>"$0.08", "Market Value"=>"$65100.00", "Day Change($)"=>"$96.00", "Day Change(%)"=>"0.15%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.24%", "Security Type"=>"Equity"}, {"Symbol"=>"DOW", "Name"=>"DOW CHEMICAL COMPANY", "Quantity"=>"450", "Price"=>"$31.38", "Change"=>"$0.54", "Market Value"=>"$14121.00", "Day Change($)"=>"$243.00", "Day Change(%)"=>"1.75%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.27%", "Security Type"=>"Equity"}, {"Symbol"=>"DFT", "Name"=>"DUPONT FABROS TECHNOLOGY", "Quantity"=>"2,400", "Price"=>"$22.87", "Change"=>"$0.25", "Market Value"=>"$54888.00", "Day Change($)"=>"$600.00", "Day Change(%)"=>"1.11%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.04%", "Security Type"=>"Equity"}, {"Symbol"=>"ETN", "Name"=>"EATON CORP PLC F", "Quantity"=>"1,080", "Price"=>"$59.75", "Change"=>"$0.30", "Market Value"=>"$64530.00", "Day Change($)"=>"$324.00", "Day Change(%)"=>"0.50%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.23%", "Security Type"=>"Equity"}, {"Symbol"=>"XOM", "Name"=>"EXXON MOBIL CORPORATION", "Quantity"=>"1,710", "Price"=>"$89.20", "Change"=>"$0.61", "Market Value"=>"$152532.00", "Day Change($)"=>"$1043.10", "Day Change(%)"=>"0.69%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.90%", "Security Type"=>"Equity"}, {"Symbol"=>"FTR", "Name"=>"FRONTIER COMMUNICATIONS", "Quantity"=>"13", "Price"=>"$4.09", "Change"=>"$0.07", "Market Value"=>"$53.17", "Day Change($)"=>"$0.91", "Day Change(%)"=>"1.74%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.00%", "Security Type"=>"Equity"}, {"Symbol"=>"GD", "Name"=>"GENERAL DYNAMICS CORP", "Quantity"=>"1,188", "Price"=>"$67.32", "Change"=>"$0.83", "Market Value"=>"$79976.16", "Day Change($)"=>"$986.04", "Day Change(%)"=>"1.25%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.52%", "Security Type"=>"Equity"}, {"Symbol"=>"GEF", "Name"=>"GREIF INC CL A", "Quantity"=>"800", "Price"=>"$51.16", "Change"=>"$1.04", "Market Value"=>"$40928.00", "Day Change($)"=>"$832.00", "Day Change(%)"=>"2.08%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.78%", "Security Type"=>"Equity"}, {"Symbol"=>"HPQ", "Name"=>"HEWLETT-PACKARD COMPANY", "Quantity"=>"1,800", "Price"=>"$19.20", "Change"=>"$2.10", "Market Value"=>"$34560.00", "Day Change($)"=>"$3780.00", "Day Change(%)"=>"12.28%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.66%", "Security Type"=>"Equity"}, {"Symbol"=>"HRL", "Name"=>"HORMEL FOODS CORP", "Quantity"=>"800", "Price"=>"$37.13", "Change"=>"$0.62", "Market Value"=>"$29704.00", "Day Change($)"=>"$496.00", "Day Change(%)"=>"1.70%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.57%", "Security Type"=>"Equity"}, {"Symbol"=>"INTC", "Name"=>"INTEL CORP", "Quantity"=>"6,400", "Price"=>"$20.42", "Change"=>"$0.17", "Market Value"=>"$130688.00", "Day Change($)"=>"$1088.00", "Day Change(%)"=>"0.84%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.49%", "Security Type"=>"Equity"}, {"Symbol"=>"ITUB", "Name"=>"ITAU UNI HOLDING SA ADRFSPONSORED ADR 1 ADR REPS 1 PREF SH", "Quantity"=>"400", "Price"=>"$17.77", "Change"=>"$0.60", "Market Value"=>"$7108.00", "Day Change($)"=>"$240.00", "Day Change(%)"=>"3.49%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.14%", "Security Type"=>"Equity"},{"Symbol"=>"K", "Name"=>"KELLOGG COMPANY", "Quantity"=>"400", "Price"=>"$60.01", "Change"=>"$0.34", "Market Value"=>"$24004.00", "Day Change($)"=>"$136.00", "Day Change(%)"=>"0.57%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.46%", "Security Type"=>"Equity"}, {"Symbol"=>"MCD", "Name"=>"MC DONALDS CORP", "Quantity"=>"1,970", "Price"=>"$95.25", "Change"=>"$1.11", "Market Value"=>"$187642.50", "Day Change($)"=>"$2186.70", "Day Change(%)"=>"1.18%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"3.57%", "Security Type"=>"Equity"}, {"Symbol"=>"MDT", "Name"=>"MEDTRONIC INC", "Quantity"=>"1,100", "Price"=>"$44.72", "Change"=>"-$0.01", "Market Value"=>"$49192.00", "Day Change($)"=>"-$11.00", "Day Change(%)"=>"-0.02%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.94%", "Security Type"=>"Equity"}, {"Symbol"=>"MSFT", "Name"=>"MICROSOFT CORP", "Quantity"=>"17,080", "Price"=>"$27.76", "Change"=>"$0.27", "Market Value"=>"$474140.80", "Day Change($)"=>"$4611.60", "Day Change(%)"=>"0.98%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"9.02%", "Security Type"=>"Equity"}, {"Symbol"=>"MON", "Name"=>"MONSANTO CO NEW DEL", "Quantity"=>"900", "Price"=>"$99.98", "Change"=>"$1.27", "Market Value"=>"$89982.00", "Day Change($)"=>"$1143.00", "Day Change(%)"=>"1.29%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.71%", "Security Type"=>"Equity"}, {"Symbol"=>"NKE", "Name"=>"NIKE INC CLASS B", "Quantity"=>"2,700", "Price"=>"$54.47", "Change"=>"-$0.07", "Market Value"=>"$147069.00", "Day Change($)"=>"-$189.00", "Day Change(%)"=>"-0.13%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.80%", "Security Type"=>"Equity"}, {"Symbol"=>"PH", "Name"=>"PARKER-HANNIFIN CORP", "Quantity"=>"300", "Price"=>"$94.54", "Change"=>"$1.28", "Market Value"=>"$28362.00", "Day Change($)"=>"$384.00", "Day Change(%)"=>"1.37%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.54%", "Security Type"=>"Equity"}, {"Symbol"=>"PEP", "Name"=>"PEPSICO INCORPORATED", "Quantity"=>"891", "Price"=>"$75.57", "Change"=>"$0.21", "Market Value"=>"$67332.87", "Day Change($)"=>"$187.11", "Day Change(%)"=>"0.28%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.28%", "Security Type"=>"Equity"}, {"Symbol"=>"PFE", "Name"=>"PFIZER INCORPORATED", "Quantity"=>"2,982", "Price"=>"$27.38", "Change"=>"-$0.03", "Market Value"=>"$81647.16", "Day Change($)"=>"-$89.46", "Day Change(%)"=>"-0.11%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.55%", "Security Type"=>"Equity"}, {"Symbol"=>"PM", "Name"=>"PHILIP MORRIS INTL INC", "Quantity"=>"900", "Price"=>"$93.42", "Change"=>"$0.29", "Market Value"=>"$84078.00", "Day Change($)"=>"$261.00", "Day Change(%)"=>"0.31%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.60%", "Security Type"=>"Equity"}, {"Symbol"=>"PG", "Name"=>"PROCTER & GAMBLE", "Quantity"=>"780", "Price"=>"$76.99", "Change"=>"-$0.05", "Market Value"=>"$60052.20", "Day Change($)"=>"-$39.00", "Day Change(%)"=>"-0.06%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.14%", "Security Type"=>"Equity"}, {"Symbol"=>"SU", "Name"=>"SUNCOR ENERGY INC NEW F", "Quantity"=>"2,160", "Price"=>"$31.27", "Change"=>"$0.35", "Market Value"=>"$67543.20", "Day Change($)"=>"$756.00", "Day Change(%)"=>"1.13%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.29%", "Security Type"=>"Equity"}, {"Symbol"=>"SYT", "Name"=>"SYNGENTA AG ADR FSPONSORED ADR 1 ADR REP 1/5 ORD", "Quantity"=>"900", "Price"=>"$84.66", "Change"=>"$0.62", "Market Value"=>"$76194.00", "Day Change($)"=>"$558.00", "Day Change(%)"=>"0.74%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.45%", "Security Type"=>"Equity"}, {"Symbol"=>"UPS", "Name"=>"UNITED PARCEL SERVICE B CLASS B", "Quantity"=>"810", "Price"=>"$82.94", "Change"=>"$0.33", "Market Value"=>"$67181.40", "Day Change($)"=>"$267.30", "Day Change(%)"=>"0.40%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.28%", "Security Type"=>"Equity"},{"Symbol"=>"UTX", "Name"=>"UNITED TECHNOLOGIES CORP", "Quantity"=>"1,476", "Price"=>"$90.49", "Change"=>"$1.08", "Market Value"=>"$133563.24", "Day Change($)"=>"$1594.08", "Day Change(%)"=>"1.21%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.54%", "Security Type"=>"Equity"}, {"Symbol"=>"VZ", "Name"=>"VERIZON COMMUNICATIONS", "Quantity"=>"1,496", "Price"=>"$45.40", "Change"=>"$0.28", "Market Value"=>"$67918.40", "Day Change($)"=>"$418.88", "Day Change(%)"=>"0.62%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.29%", "Security Type"=>"Equity"}, {"Symbol"=>"V", "Name"=>"VISA INC CL A CLASS A", "Quantity"=>"450", "Price"=>"$159.43", "Change"=>"$1.99", "Market Value"=>"$71743.50", "Day Change($)"=>"$895.50", "Day Change(%)"=>"1.26%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.37%", "Security Type"=>"Equity"}, {"Symbol"=>"WAG", "Name"=>"WALGREEN COMPANY", "Quantity"=>"4,800", "Price"=>"$41.81", "Change"=>"$0.19", "Market Value"=>"$200688.00", "Day Change($)"=>"$912.00", "Day Change(%)"=>"0.46%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"3.82%", "Security Type"=>"Equity"}, {"Symbol"=>"VTA", "Name"=>"INVESCO DYNAMIC CREDIT OPPORTUNITIES FUND", "Quantity"=>"3,500", "Price"=>"$13.27", "Change"=>"-$0.03", "Market Value"=>"$46445.00", "Day Change($)"=>"-$105.00", "Day Change(%)"=>"-0.23%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.88%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"LQD", "Name"=>"ISHARES IBOXX INVESTOP IBOXX $ INVESTOP CORP BOND FUND", "Quantity"=>"940", "Price"=>"$119.77", "Change"=>"$0.08", "Market Value"=>"$112583.80", "Day Change($)"=>"$75.20", "Day Change(%)"=>"0.07%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.14%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"GSG", "Name"=>"ISHARES S&P GSCI CMDTY COMMODITY INDEXED TRUST", "Quantity"=>"100", "Price"=>"$33.20", "Change"=>"$0.11", "Market Value"=>"$3320.00", "Day Change($)"=>"$11.00", "Day Change(%)"=>"0.33%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.06%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"EFA", "Name"=>"ISHARES TR MSCI EAFE FD MSCI EAFE INDEX FUND", "Quantity"=>"9,050", "Price"=>"$58.49", "Change"=>"$0.83", "Market Value"=>"$529334.50", "Day Change($)"=>"$7511.50", "Day Change(%)"=>"1.44%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"10.07%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"PGF", "Name"=>"POWERSHS EXCH TRAD FD TRPOWERSHARES FINANCIAL PREFERRED PORTFOLIO", "Quantity"=>"21,800", "Price"=>"$18.45", "Change"=>"$0.01", "Market Value"=>"$402210.00", "Day Change($)"=>"$218.00", "Day Change(%)"=>"0.05%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"7.66%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"JNK", "Name"=>"SPDR BARCLAYS ETF HIGH YIELD VERY LIQUID INDEX", "Quantity"=>"1,000", "Price"=>"$40.83", "Change"=>"$0.05", "Market Value"=>"$40830.00", "Day Change($)"=>"$50.00", "Day Change(%)"=>"0.12%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.78%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"Cash & Money Market", "Name"=>"", "Quantity"=>"", "Price"=>"", "Change"=>"", "Market Value"=>"$61622.39", "Day Change($)"=>"N/A", "Day Change(%)"=>"N/A", "Reinvest Dividends?"=>"--", "Capital Gain"=>"--", "% of Account"=>"1.17%", "Security Type"=>"Cash & Money Market"}, {"Symbol"=>"Total Market Value", "Name"=>"", "Quantity"=>"", "Price"=>"", "Change"=>"", "Market Value"=>"$5253988.67", "Day Change($)"=>nil, "Day Change(%)"=>nil, "Reinvest Dividends?"=>nil, "Capital Gain"=>nil, "% of Account"=>nil, "Security Type"=>nil}]

  portfolio = Portfolio.create!( :name => 'SLAT', :user_id => 1, :cash => 6000000 )
  puts 'New portfolio created: ' + portfolio.name + ' for ' + portfolio.user_id.to_s
  user = User.find_by_email('andy@denenberg.net')

positions[0..-3].each do |pos|
  position = purch( pos['Quantity'].gsub(',',''), pos['Symbol'].downcase, pos['Price'].gsub('$',''), "2013-02-23", user, "", portfolio )
  puts Stock.add_position ( position )
end

end
  
desc "Setup SLAT2"
task :create_SLAT2 => :environment do

  positions = [{"Symbol"=>"MMM", "Name"=>"3M COMPANY", "Quantity"=>"180", "Price"=>"$103.77", "Change"=>"-$0.23", "Market Value"=>"$18678.60", "Day Change($)"=>"-$41.40", "Day Change(%)"=>"-0.22%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.78%", "Security Type"=>"Equity"},
     {"Symbol"=>"T", "Name"=>"A T & T INC NEW", "Quantity"=>"900", "Price"=>"$36.01", "Change"=>"$0.10", "Market Value"=>"$32409.00", "Day Change($)"=>"$90.00", "Day Change(%)"=>"0.28%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.36%", "Security Type"=>"Equity"},
     {"Symbol"=>"MO", "Name"=>"ALTRIA GROUP INC", "Quantity"=>"1,440", "Price"=>"$33.49", "Change"=>"-$0.06", "Market Value"=>"$48225.60", "Day Change($)"=>"-$86.40", "Day Change(%)"=>"-0.18%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.02%", "Security Type"=>"Equity"},
     {"Symbol"=>"ACO", "Name"=>"AMCOL INTERNATIONAL CORP", "Quantity"=>"270", "Price"=>"$29.23", "Change"=>"-$0.01", "Market Value"=>"$7892.10", "Day Change($)"=>"-$2.70", "Day Change(%)"=>"-0.03%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.33%", "Security Type"=>"Equity"},
      {"Symbol"=>"AAPL", "Name"=>"APPLE INC", "Quantity"=>"800", "Price"=>"$430.47", "Change"=>"-$10.93", "Market Value"=>"$344376.00", "Day Change($)"=>"-$8744.00", "Day Change(%)"=>"-2.48%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"14.45%", "Security Type"=>"Equity"},
       {"Symbol"=>"ADM", "Name"=>"ARCHER-DANIELS-MIDLND CO", "Quantity"=>"1,044", "Price"=>"$31.97", "Change"=>"$0.11", "Market Value"=>"$33376.68", "Day Change($)"=>"$114.84", "Day Change(%)"=>"0.35%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.40%", "Security Type"=>"Equity"},
        {"Symbol"=>"BMO", "Name"=>"BANK MONTREAL QUEBEC F", "Quantity"=>"360", "Price"=>"$62.36", "Change"=>"$0.13", "Market Value"=>"$22449.60", "Day Change($)"=>"$46.80", "Day Change(%)"=>"0.21%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.94%", "Security Type"=>"Equity"},
         {"Symbol"=>"BA", "Name"=>"BOEING CO", "Quantity"=>"180", "Price"=>"$77.28", "Change"=>"$0.38", "Market Value"=>"$13910.40", "Day Change($)"=>"$68.40", "Day Change(%)"=>"0.49%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.58%", "Security Type"=>"Equity"},
          {"Symbol"=>"BWA", "Name"=>"BORG WARNER INC", "Quantity"=>"630", "Price"=>"$75.07", "Change"=>"$0.66", "Market Value"=>"$47294.10", "Day Change($)"=>"$415.80", "Day Change(%)"=>"0.89%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.98%", "Security Type"=>"Equity"},
           {"Symbol"=>"BG", "Name"=>"BUNGE LIMITED F", "Quantity"=>"450", "Price"=>"$73.15", "Change"=>"-$0.96", "Market Value"=>"$32917.50", "Day Change($)"=>"-$432.00", "Day Change(%)"=>"-1.30%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.38%", "Security Type"=>"Equity"},
            {"Symbol"=>"CSX", "Name"=>"C S X CORP", "Quantity"=>"540", "Price"=>"$22.97", "Change"=>"$0.03", "Market Value"=>"$12403.80", "Day Change($)"=>"$16.20", "Day Change(%)"=>"0.13%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.52%", "Security Type"=>"Equity"},
             {"Symbol"=>"COF", "Name"=>"CAPITAL ONE FINANCIAL CP", "Quantity"=>"360", "Price"=>"$51.87", "Change"=>"$0.84", "Market Value"=>"$18673.20", "Day Change($)"=>"$302.40", "Day Change(%)"=>"1.65%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.78%", "Security Type"=>"Equity"},
              {"Symbol"=>"CAT", "Name"=>"CATERPILLAR INC", "Quantity"=>"180", "Price"=>"$91.36", "Change"=>"-$1.01", "Market Value"=>"$16444.80", "Day Change($)"=>"-$181.80", "Day Change(%)"=>"-1.09%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.69%", "Security Type"=>"Equity"},
               {"Symbol"=>"CNP", "Name"=>"CENTERPOINT ENERGY INC", "Quantity"=>"2,700", "Price"=>"$21.53", "Change"=>"$0.10", "Market Value"=>"$58131.00", "Day Change($)"=>"$270.00", "Day Change(%)"=>"0.47%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.44%", "Security Type"=>"Equity"},
                {"Symbol"=>"CTL", "Name"=>"CENTURYLINK INC", "Quantity"=>"900", "Price"=>"$34.89", "Change"=>"$0.22", "Market Value"=>"$31401.00", "Day Change($)"=>"$198.00", "Day Change(%)"=>"0.63%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.32%", "Security Type"=>"Equity"},
     {"Symbol"=>"CVX", "Name"=>"CHEVRON CORPORATION", "Quantity"=>"270", "Price"=>"$116.90", "Change"=>"-$0.25", "Market Value"=>"$31563.00", "Day Change($)"=>"-$67.50", "Day Change(%)"=>"-0.21%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.32%", "Security Type"=>"Equity"},
      {"Symbol"=>"CSCO", "Name"=>"CISCO SYSTEMS INC", "Quantity"=>"6,250", "Price"=>"$20.83", "Change"=>"-$0.03", "Market Value"=>"$130187.50", "Day Change($)"=>"-$156.25", "Day Change(%)"=>"-0.12%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"5.46%", "Security Type"=>"Equity"},
       {"Symbol"=>"CMCSA", "Name"=>"COMCAST CORP NEW CL A", "Quantity"=>"630", "Price"=>"$40.03", "Change"=>"$0.24", "Market Value"=>"$25218.90", "Day Change($)"=>"$151.20", "Day Change(%)"=>"0.60%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.06%", "Security Type"=>"Equity"},
        {"Symbol"=>"CNX", "Name"=>"CONSOL ENERGY INC", "Quantity"=>"900", "Price"=>"$30.64", "Change"=>"-$1.51", "Market Value"=>"$27576.00", "Day Change($)"=>"-$1359.00", "Day Change(%)"=>"-4.70%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.16%", "Security Type"=>"Equity"},
         {"Symbol"=>"COV", "Name"=>"COVIDIEN PLC NEW F", "Quantity"=>"900", "Price"=>"$63.58", "Change"=>"$0.01", "Market Value"=>"$57222.00", "Day Change($)"=>"$9.00", "Day Change(%)"=>"0.02%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.40%", "Security Type"=>"Equity"},
          {"Symbol"=>"CMI", "Name"=>"CUMMINS INC", "Quantity"=>"360", "Price"=>"$115.05", "Change"=>"-$0.82", "Market Value"=>"$41418.00", "Day Change($)"=>"-$295.20", "Day Change(%)"=>"-0.71%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.74%", "Security Type"=>"Equity"},
           {"Symbol"=>"DEO", "Name"=>"DIAGEO PLC NEW ADR FSPONSORED ADR 1 ADR REPS 4 ORD", "Quantity"=>"450", "Price"=>"$118.69", "Change"=>"-$1.02", "Market Value"=>"$53410.50", "Day Change($)"=>"-$459.00", "Day Change(%)"=>"-0.85%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.24%", "Security Type"=>"Equity"},
            {"Symbol"=>"DIS", "Name"=>"DISNEY WALT CO", "Quantity"=>"900", "Price"=>"$55.33", "Change"=>"$0.74", "Market Value"=>"$49797.00", "Day Change($)"=>"$666.00", "Day Change(%)"=>"1.36%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.09%", "Security Type"=>"Equity"},
             {"Symbol"=>"DOW", "Name"=>"DOW CHEMICAL COMPANY", "Quantity"=>"720", "Price"=>"$31.81", "Change"=>"$0.09", "Market Value"=>"$22903.20", "Day Change($)"=>"$64.80", "Day Change(%)"=>"0.28%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.96%", "Security Type"=>"Equity"},
              {"Symbol"=>"DFT", "Name"=>"DUPONT FABROS TECHNOLOGY", "Quantity"=>"1,080", "Price"=>"$23.67", "Change"=>"$0.51", "Market Value"=>"$25563.60", "Day Change($)"=>"$550.80", "Day Change(%)"=>"2.20%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.07%", "Security Type"=>"Equity"},
               {"Symbol"=>"EGP", "Name"=>"EASTGROUP PPTY MD CORP REIT", "Quantity"=>"450", "Price"=>"$57.04", "Change"=>"$0.23", "Market Value"=>"$25668.00", "Day Change($)"=>"$103.50", "Day Change(%)"=>"0.40%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.08%", "Security Type"=>"Equity"},
                {"Symbol"=>"FLS", "Name"=>"FLOWSERVE CORPORATION", "Quantity"=>"135", "Price"=>"$161.55", "Change"=>"$1.05", "Market Value"=>"$21809.25", "Day Change($)"=>"$141.75", "Day Change(%)"=>"0.65%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.92%", "Security Type"=>"Equity"},
                 {"Symbol"=>"GE", "Name"=>"GENERAL ELECTRIC COMPANY", "Quantity"=>"2,250", "Price"=>"$23.19", "Change"=>"-$0.03", "Market Value"=>"$52177.50", "Day Change($)"=>"-$67.50", "Day Change(%)"=>"-0.13%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.19%", "Security Type"=>"Equity"},
                  {"Symbol"=>"GS", "Name"=>"GOLDMAN SACHS GROUP INC", "Quantity"=>"450", "Price"=>"$150.53", "Change"=>"$0.77", "Market Value"=>"$67738.50", "Day Change($)"=>"$346.50", "Day Change(%)"=>"0.51%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.84%", "Security Type"=>"Equity"},
      {"Symbol"=>"HIG", "Name"=>"HARTFORD FINL SVCS GRP", "Quantity"=>"360", "Price"=>"$23.68", "Change"=>"$0.07", "Market Value"=>"$8524.80", "Day Change($)"=>"$25.20", "Day Change(%)"=>"0.30%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.36%", "Security Type"=>"Equity"},
       {"Symbol"=>"HON", "Name"=>"HONEYWELL INTERNATIONAL", "Quantity"=>"450", "Price"=>"$70.05", "Change"=>"-$0.05", "Market Value"=>"$31522.50", "Day Change($)"=>"-$22.50", "Day Change(%)"=>"-0.07%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.32%", "Security Type"=>"Equity"},
        {"Symbol"=>"HUM", "Name"=>"HUMANA INC", "Quantity"=>"270", "Price"=>"$67.88", "Change"=>"-$0.38", "Market Value"=>"$18327.60", "Day Change($)"=>"-$102.60", "Day Change(%)"=>"-0.56%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.77%", "Security Type"=>"Equity"},
         {"Symbol"=>"INTC", "Name"=>"INTEL CORP", "Quantity"=>"1,800", "Price"=>"$21.03", "Change"=>"$0.15", "Market Value"=>"$37854.00", "Day Change($)"=>"$270.00", "Day Change(%)"=>"0.72%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.59%", "Security Type"=>"Equity"},
          {"Symbol"=>"JNJ", "Name"=>"JOHNSON & JOHNSON", "Quantity"=>"720", "Price"=>"$76.70", "Change"=>"$0.59", "Market Value"=>"$55224.00", "Day Change($)"=>"$424.80", "Day Change(%)"=>"0.78%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.32%", "Security Type"=>"Equity"},
           {"Symbol"=>"JPM", "Name"=>"JPMORGAN CHASE & CO", "Quantity"=>"810", "Price"=>"$48.91", "Change"=>"-$0.01", "Market Value"=>"$39617.10", "Day Change($)"=>"-$8.10", "Day Change(%)"=>"-0.02%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.66%", "Security Type"=>"Equity"},
            {"Symbol"=>"KMB", "Name"=>"KIMBERLY-CLARK CORP", "Quantity"=>"630", "Price"=>"$94.30", "Change"=>"$0.02", "Market Value"=>"$59409.00", "Day Change($)"=>"$12.60", "Day Change(%)"=>"0.02%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.49%", "Security Type"=>"Equity"},
             {"Symbol"=>"KMP", "Name"=>"KINDER MORGAN ENERGY LP UNIT LTD PARTNERSHIP INT", "Quantity"=>"270", "Price"=>"$86.72", "Change"=>"-$0.59", "Market Value"=>"$23414.40", "Day Change($)"=>"-$159.30", "Day Change(%)"=>"-0.68%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.98%", "Security Type"=>"Equity"},
              {"Symbol"=>"LDR", "Name"=>"LANDAUER INC", "Quantity"=>"450", "Price"=>"$58.99", "Change"=>"$0.28", "Market Value"=>"$26545.50", "Day Change($)"=>"$126.00", "Day Change(%)"=>"0.48%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.11%", "Security Type"=>"Equity"},
               {"Symbol"=>"MRK", "Name"=>"MERCK & CO INC NEW", "Quantity"=>"1,170", "Price"=>"$42.63", "Change"=>"-$0.10", "Market Value"=>"$49877.10", "Day Change($)"=>"-$117.00", "Day Change(%)"=>"-0.23%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.09%", "Security Type"=>"Equity"},
                {"Symbol"=>"NVS", "Name"=>"NOVARTIS A G SPON ADR FSPONSORED ADR 1 ADR REP 1 ORD", "Quantity"=>"360", "Price"=>"$68.15", "Change"=>"$0.35", "Market Value"=>"$24534.00", "Day Change($)"=>"$126.00", "Day Change(%)"=>"0.52%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.03%", "Security Type"=>"Equity"},
                 {"Symbol"=>"ORCL", "Name"=>"ORACLE CORPORATION", "Quantity"=>"900", "Price"=>"$34.63", "Change"=>"$0.39", "Market Value"=>"$31167.00", "Day Change($)"=>"$351.00", "Day Change(%)"=>"1.14%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.31%", "Security Type"=>"Equity"},
                  {"Symbol"=>"PH", "Name"=>"PARKER-HANNIFIN CORP", "Quantity"=>"360", "Price"=>"$94.45", "Change"=>"-$0.03", "Market Value"=>"$34002.00", "Day Change($)"=>"-$10.80", "Day Change(%)"=>"-0.03%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.43%", "Security Type"=>"Equity"},
                   {"Symbol"=>"PAYX", "Name"=>"PAYCHEX INC", "Quantity"=>"4,266", "Price"=>"$33.35", "Change"=>"$0.25", "Market Value"=>"$142271.10", "Day Change($)"=>"$1045.17", "Day Change(%)"=>"0.74%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"5.97%", "Security Type"=>"Equity"},
                    {"Symbol"=>"PSX", "Name"=>"PHILLIPS 66", "Quantity"=>"720", "Price"=>"$63.90", "Change"=>"$0.94", "Market Value"=>"$46008.00", "Day Change($)"=>"$676.80", "Day Change(%)"=>"1.49%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.93%", "Security Type"=>"Equity"},
                     {"Symbol"=>"PX", "Name"=>"PRAXAIR INC", "Quantity"=>"450", "Price"=>"$113.51", "Change"=>"$0.46", "Market Value"=>"$51079.50", "Day Change($)"=>"$207.00", "Day Change(%)"=>"0.41%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.14%", "Security Type"=>"Equity"},
                      {"Symbol"=>"QCOM", "Name"=>"QUALCOMM INC", "Quantity"=>"270", "Price"=>"$66.30", "Change"=>"$0.66", "Market Value"=>"$17901.00", "Day Change($)"=>"$178.20", "Day Change(%)"=>"1.01%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.75%", "Security Type"=>"Equity"},
                       {"Symbol"=>"RIO", "Name"=>"RIO TINTO PLC SPON ADR FSPONSORED ADR 1 ADR REPS 1 ORD", "Quantity"=>"684", "Price"=>"$51.75", "Change"=>"-$1.89", "Market Value"=>"$35397.00", "Day Change($)"=>"-$1292.76", "Day Change(%)"=>"-3.52%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.49%", "Security Type"=>"Equity"},
                        {"Symbol"=>"SBUX", "Name"=>"STARBUCKS CORP", "Quantity"=>"360", "Price"=>"$54.87", "Change"=>"$0.02", "Market Value"=>"$19753.20", "Day Change($)"=>"$7.20", "Day Change(%)"=>"0.04%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.83%", "Security Type"=>"Equity"},
                         {"Symbol"=>"TOT", "Name"=>"TOTAL S A ADR F1 ADR REP 1 ORD", "Quantity"=>"180", "Price"=>"$50.07", "Change"=>"$0.05", "Market Value"=>"$9012.60", "Day Change($)"=>"$9.00", "Day Change(%)"=>"0.10%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.38%", "Security Type"=>"Equity"},
                          {"Symbol"=>"UIL", "Name"=>"UIL HOLDINGS CO", "Quantity"=>"630", "Price"=>"$39.36", "Change"=>"$0.20", "Market Value"=>"$24796.80", "Day Change($)"=>"$126.00", "Day Change(%)"=>"0.51%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.04%", "Security Type"=>"Equity"},
                           {"Symbol"=>"VALE", "Name"=>"VALE SA ADR FSPONSORED ADR 1 ADR REP 1 ORD", "Quantity"=>"2,700", "Price"=>"$18.55", "Change"=>"-$0.44", "Market Value"=>"$50085.00", "Day Change($)"=>"-$1188.00", "Day Change(%)"=>"-2.32%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.10%", "Security Type"=>"Equity"},
                            {"Symbol"=>"VMW", "Name"=>"VMWARE INC CL A CLASS A", "Quantity"=>"135", "Price"=>"$73.55", "Change"=>"$1.72", "Market Value"=>"$9929.25", "Day Change($)"=>"$232.20", "Day Change(%)"=>"2.39%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.42%", "Security Type"=>"Equity"},
                             {"Symbol"=>"EWA", "Name"=>"ISHARES MSCI AUS IDX FD AUSTRALIA INDEX FUND", "Quantity"=>"900", "Price"=>"$26.94", "Change"=>"$0.06", "Market Value"=>"$24246.00", "Day Change($)"=>"$54.00", "Day Change(%)"=>"0.22%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.02%", "Security Type"=>"ETFs & Closed End Funds"},
                              {"Symbol"=>"EWH", "Name"=>"ISHARES MSCI HK IDX FD HONG KONG INDEX FUND", "Quantity"=>"1,800", "Price"=>"$20.12", "Change"=>"$0.00", "Market Value"=>"$36216.00", "Day Change($)"=>"$0.00", "Day Change(%)"=>"0.00%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.52%", "Security Type"=>"ETFs & Closed End Funds"},
                               {"Symbol"=>"EWT", "Name"=>"ISHARES MSCI TAIWAN INDXTAIWAN INDEX FUND", "Quantity"=>"1,350", "Price"=>"$13.55", "Change"=>"$0.04", "Market Value"=>"$18299.25", "Day Change($)"=>"$47.25", "Day Change(%)"=>"0.26%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.77%", "Security Type"=>"ETFs & Closed End Funds"},
                                {"Symbol"=>"JNK", "Name"=>"SPDR BARCLAYS ETF HIGH YIELD VERY LIQUID INDEX", "Quantity"=>"900", "Price"=>"$40.83", "Change"=>"-$0.07", "Market Value"=>"$36747.00", "Day Change($)"=>"-$58.50", "Day Change(%)"=>"-0.16%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.54%", "Security Type"=>"ETFs & Closed End Funds"} ]

  portfolio = Portfolio.create!( :name => 'SLAT2', :user_id => 1, :cash => 6000000 )
  puts 'New portfolio created: ' + portfolio.name + ' for ' + portfolio.user_id.to_s
  user = User.find_by_email('andy@denenberg.net')

positions.each do |pos|
  position = purch( pos['Quantity'].gsub(',',''), pos['Symbol'].downcase, pos['Price'].gsub('$',''), "2013-02-23", user, "", portfolio )
  s = Stock.add_position(position)
end

  portfolio = Portfolio.find_by_name('SLAT2')
  portfolio.cash = 50395.46
  portfolio.save
  
end  

desc "Setup MSA"
task :create_MSA => :environment do

csv = [
 [ 'AAPL','APPLE INC',120,430.47                  ],
 [ 'ATMI','ATMI INC COM',26190,21.95           ],
 [ 'CSCO','CISCO SYSTEMS INC',14100,20.83      ],
 [ 'CVS','CVS CAREMARK CORP',690,51.56            ],
 [ 'GS','GOLDMAN SACHS GROUP INC',80,150.53       ],
 [ 'MCD','MCDONALDS CORP COM',260,95.68           ],
 [ 'MO','ALTRIA GROUP INC',300,33.49              ],
 [ 'MSFT','MICROSOFT CORP',7,153,27.95          ],
 [ 'NKE','NIKE INC CL B COM STK',500,54.82        ],
 [ 'PFE','PFIZER INC',290,27.39                   ],
 [ 'PM','PHILIP MORRIS INTL',340,91.44            ],
 [ 'SIAL','SIGMA-ALDRICH CORP',200,77.38          ],
 [ 'STT','STATE STREET CORP COM',377,56.31        ],
 [ 'SYK','STRYKER CORP COM',2130,64.9          ],
 [ 'UTX','UNITED TECHNOLOGIES CORP',400,90.13     ],
 [ 'WAG','WALGREEN CO COM',840,41.32              ],
 [ 'XOM','EXXON MOBIL CORP',500,89.43             ],
 [ 'ZBRA','ZEBRA TECHNOLOGIES CORP CL A',750,44.05]]

 portfolio = Portfolio.create!( :name => 'MSA', :user_id => 1, :cash => 6000000 )
 puts 'New portfolio created: ' + portfolio.name + ' for ' + portfolio.user_id.to_s
 user = User.find_by_email('andy@denenberg.net')

 csv.each do |pos|
   position = purch( pos[2], pos[0].downcase, pos[3], "2013-02-23", user, "", portfolio )
   s = Stock.add_position(position)
 end

 portfolio = Portfolio.find_by_name('SLAT2')
 portfolio.cash = 70206.42
 portfolio.save


end

  
end



   
   
   
   
   
   
   
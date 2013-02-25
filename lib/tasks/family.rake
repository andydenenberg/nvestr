
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


desc "Setup Family Members"
task :create_SLAT => :environment do

  positions = [{"Symbol"=>"ATMI", "Name"=>"A T M I INC", "Quantity"=>"2,200", "Price"=>"$22.00", "Change"=>"$0.11", "Market Value"=>"$48400.00", "Day Change($)"=>"$242.00", "Day Change(%)"=>"0.50%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.92%", "Security Type"=>"Equity"}, {"Symbol"=>"ACE", "Name"=>"ACE LIMITED NEW F", "Quantity"=>"1,674", "Price"=>"$86.69", "Change"=>"$0.54", "Market Value"=>"$145119.06", "Day Change($)"=>"$903.96", "Day Change(%)"=>"0.63%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.76%", "Security Type"=>"Equity"}, {"Symbol"=>"A", "Name"=>"AGILENT TECHNOLOGIES INC", "Quantity"=>"555", "Price"=>"$41.80", "Change"=>"$0.17", "Market Value"=>"$23199.00", "Day Change($)"=>"$94.35", "Day Change(%)"=>"0.41%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.44%", "Security Type"=>"Equity"}, {"Symbol"=>"APD", "Name"=>"AIR PROD & CHEMICALS INC", "Quantity"=>"900", "Price"=>"$86.09", "Change"=>"$0.42", "Market Value"=>"$77481.00", "Day Change($)"=>"$378.00", "Day Change(%)"=>"0.49%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.47%", "Security Type"=>"Equity"}, {"Symbol"=>"AAPL", "Name"=>"APPLE INC", "Quantity"=>"20", "Price"=>"$450.81", "Change"=>"$4.75", "Market Value"=>"$9016.20", "Day Change($)"=>"$95.00", "Day Change(%)"=>"1.06%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.17%", "Security Type"=>"Equity"}, {"Symbol"=>"AMAT", "Name"=>"APPLIED MATERIALS INC", "Quantity"=>"552", "Price"=>"$13.57", "Change"=>"$0.32", "Market Value"=>"$7490.64", "Day Change($)"=>"$176.64", "Day Change(%)"=>"2.42%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.14%", "Security Type"=>"Equity"}, {"Symbol"=>"ADSK", "Name"=>"AUTODESK INC", "Quantity"=>"1,900", "Price"=>"$37.91", "Change"=>"-$0.06", "Market Value"=>"$72029.00", "Day Change($)"=>"-$114.00", "Day Change(%)"=>"-0.16%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.37%", "Security Type"=>"Equity"}, {"Symbol"=>"BASFY", "Name"=>"BASF SE ADR FSPONSORED ADR 1 ADR REPS 1 ORD", "Quantity"=>"810", "Price"=>"$98.56", "Change"=>"$2.26", "Market Value"=>"$79833.60", "Day Change($)"=>"$1830.60", "Day Change(%)"=>"2.35%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.52%", "Security Type"=>"Equity"}, {"Symbol"=>"BHP", "Name"=>"BHP BILLITON LTD ADR FSPONSORED ADR 1 ADR REP 2 ORD", "Quantity"=>"900", "Price"=>"$75.77", "Change"=>"$0.80", "Market Value"=>"$68193.00", "Day Change($)"=>"$720.00", "Day Change(%)"=>"1.07%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.30%", "Security Type"=>"Equity"}, {"Symbol"=>"CVS", "Name"=>"C V S CAREMARK CORP", "Quantity"=>"1,800", "Price"=>"$51.35", "Change"=>"-$0.51", "Market Value"=>"$92430.00", "Day Change($)"=>"-$918.00", "Day Change(%)"=>"-0.98%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.76%", "Security Type"=>"Equity"}, {"Symbol"=>"CCL", "Name"=>"CARNIVAL CORP NEW FPAIRED STK SPECIAL VTG TR", "Quantity"=>"900", "Price"=>"$34.99", "Change"=>"-$0.37", "Market Value"=>"$31491.00", "Day Change($)"=>"-$333.00", "Day Change(%)"=>"-1.05%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.60%", "Security Type"=>"Equity"}, {"Symbol"=>"CTL", "Name"=>"CENTURYLINK INC", "Quantity"=>"1,012", "Price"=>"$34.64", "Change"=>"$0.37", "Market Value"=>"$35055.68", "Day Change($)"=>"$374.44", "Day Change(%)"=>"1.08%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.67%", "Security Type"=>"Equity"}, {"Symbol"=>"CSCO", "Name"=>"CISCO SYSTEMS INC", "Quantity"=>"22,000", "Price"=>"$20.90", "Change"=>"$0.14", "Market Value"=>"$459800.00", "Day Change($)"=>"$3080.00", "Day Change(%)"=>"0.67%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"8.75%", "Security Type"=>"Equity"}, {"Symbol"=>"KO", "Name"=>"COCA COLA COMPANY", "Quantity"=>"3,735", "Price"=>"$38.52", "Change"=>"$0.81", "Market Value"=>"$143872.20", "Day Change($)"=>"$3025.35", "Day Change(%)"=>"2.15%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.74%", "Security Type"=>"Equity"}, {"Symbol"=>"COP", "Name"=>"CONOCOPHILLIPS", "Quantity"=>"1,620", "Price"=>"$58.20", "Change"=>"$0.09", "Market Value"=>"$94284.00", "Day Change($)"=>"$145.80", "Day Change(%)"=>"0.15%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.79%", "Security Type"=>"Equity"}, {"Symbol"=>"DE", "Name"=>"DEERE & CO", "Quantity"=>"200", "Price"=>"$87.13", "Change"=>"$0.07", "Market Value"=>"$17426.00", "Day Change($)"=>"$14.00", "Day Change(%)"=>"0.08%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.33%", "Security Type"=>"Equity"}, {"Symbol"=>"DIS", "Name"=>"DISNEY WALT CO", "Quantity"=>"1,200", "Price"=>"$54.25", "Change"=>"$0.08", "Market Value"=>"$65100.00", "Day Change($)"=>"$96.00", "Day Change(%)"=>"0.15%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.24%", "Security Type"=>"Equity"}, {"Symbol"=>"DOW", "Name"=>"DOW CHEMICAL COMPANY", "Quantity"=>"450", "Price"=>"$31.38", "Change"=>"$0.54", "Market Value"=>"$14121.00", "Day Change($)"=>"$243.00", "Day Change(%)"=>"1.75%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.27%", "Security Type"=>"Equity"}, {"Symbol"=>"DFT", "Name"=>"DUPONT FABROS TECHNOLOGY", "Quantity"=>"2,400", "Price"=>"$22.87", "Change"=>"$0.25", "Market Value"=>"$54888.00", "Day Change($)"=>"$600.00", "Day Change(%)"=>"1.11%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.04%", "Security Type"=>"Equity"}, {"Symbol"=>"ETN", "Name"=>"EATON CORP PLC F", "Quantity"=>"1,080", "Price"=>"$59.75", "Change"=>"$0.30", "Market Value"=>"$64530.00", "Day Change($)"=>"$324.00", "Day Change(%)"=>"0.50%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.23%", "Security Type"=>"Equity"}, {"Symbol"=>"XOM", "Name"=>"EXXON MOBIL CORPORATION", "Quantity"=>"1,710", "Price"=>"$89.20", "Change"=>"$0.61", "Market Value"=>"$152532.00", "Day Change($)"=>"$1043.10", "Day Change(%)"=>"0.69%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.90%", "Security Type"=>"Equity"}, {"Symbol"=>"FTR", "Name"=>"FRONTIER COMMUNICATIONS", "Quantity"=>"13", "Price"=>"$4.09", "Change"=>"$0.07", "Market Value"=>"$53.17", "Day Change($)"=>"$0.91", "Day Change(%)"=>"1.74%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.00%", "Security Type"=>"Equity"}, {"Symbol"=>"GD", "Name"=>"GENERAL DYNAMICS CORP", "Quantity"=>"1,188", "Price"=>"$67.32", "Change"=>"$0.83", "Market Value"=>"$79976.16", "Day Change($)"=>"$986.04", "Day Change(%)"=>"1.25%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.52%", "Security Type"=>"Equity"}, {"Symbol"=>"GEF", "Name"=>"GREIF INC CL A", "Quantity"=>"800", "Price"=>"$51.16", "Change"=>"$1.04", "Market Value"=>"$40928.00", "Day Change($)"=>"$832.00", "Day Change(%)"=>"2.08%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.78%", "Security Type"=>"Equity"}, {"Symbol"=>"HPQ", "Name"=>"HEWLETT-PACKARD COMPANY", "Quantity"=>"1,800", "Price"=>"$19.20", "Change"=>"$2.10", "Market Value"=>"$34560.00", "Day Change($)"=>"$3780.00", "Day Change(%)"=>"12.28%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.66%", "Security Type"=>"Equity"}, {"Symbol"=>"HRL", "Name"=>"HORMEL FOODS CORP", "Quantity"=>"800", "Price"=>"$37.13", "Change"=>"$0.62", "Market Value"=>"$29704.00", "Day Change($)"=>"$496.00", "Day Change(%)"=>"1.70%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.57%", "Security Type"=>"Equity"}, {"Symbol"=>"INTC", "Name"=>"INTEL CORP", "Quantity"=>"6,400", "Price"=>"$20.42", "Change"=>"$0.17", "Market Value"=>"$130688.00", "Day Change($)"=>"$1088.00", "Day Change(%)"=>"0.84%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.49%", "Security Type"=>"Equity"}, {"Symbol"=>"ITUB", "Name"=>"ITAU UNI HOLDING SA ADRFSPONSORED ADR 1 ADR REPS 1 PREF SH", "Quantity"=>"400", "Price"=>"$17.77", "Change"=>"$0.60", "Market Value"=>"$7108.00", "Day Change($)"=>"$240.00", "Day Change(%)"=>"3.49%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.14%", "Security Type"=>"Equity"}, {"Symbol"=>"K", "Name"=>"KELLOGG COMPANY", "Quantity"=>"400", "Price"=>"$60.01", "Change"=>"$0.34", "Market Value"=>"$24004.00", "Day Change($)"=>"$136.00", "Day Change(%)"=>"0.57%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.46%", "Security Type"=>"Equity"}, {"Symbol"=>"MCD", "Name"=>"MC DONALDS CORP", "Quantity"=>"1,970", "Price"=>"$95.25", "Change"=>"$1.11", "Market Value"=>"$187642.50", "Day Change($)"=>"$2186.70", "Day Change(%)"=>"1.18%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"3.57%", "Security Type"=>"Equity"}, {"Symbol"=>"MDT", "Name"=>"MEDTRONIC INC", "Quantity"=>"1,100", "Price"=>"$44.72", "Change"=>"-$0.01", "Market Value"=>"$49192.00", "Day Change($)"=>"-$11.00", "Day Change(%)"=>"-0.02%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.94%", "Security Type"=>"Equity"}, {"Symbol"=>"MSFT", "Name"=>"MICROSOFT CORP", "Quantity"=>"17,080", "Price"=>"$27.76", "Change"=>"$0.27", "Market Value"=>"$474140.80", "Day Change($)"=>"$4611.60", "Day Change(%)"=>"0.98%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"9.02%", "Security Type"=>"Equity"}, {"Symbol"=>"MON", "Name"=>"MONSANTO CO NEW DEL", "Quantity"=>"900", "Price"=>"$99.98", "Change"=>"$1.27", "Market Value"=>"$89982.00", "Day Change($)"=>"$1143.00", "Day Change(%)"=>"1.29%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.71%", "Security Type"=>"Equity"}, {"Symbol"=>"NKE", "Name"=>"NIKE INC CLASS B", "Quantity"=>"2,700", "Price"=>"$54.47", "Change"=>"-$0.07", "Market Value"=>"$147069.00", "Day Change($)"=>"-$189.00", "Day Change(%)"=>"-0.13%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.80%", "Security Type"=>"Equity"}, {"Symbol"=>"PH", "Name"=>"PARKER-HANNIFIN CORP", "Quantity"=>"300", "Price"=>"$94.54", "Change"=>"$1.28", "Market Value"=>"$28362.00", "Day Change($)"=>"$384.00", "Day Change(%)"=>"1.37%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.54%", "Security Type"=>"Equity"}, {"Symbol"=>"PEP", "Name"=>"PEPSICO INCORPORATED", "Quantity"=>"891", "Price"=>"$75.57", "Change"=>"$0.21", "Market Value"=>"$67332.87", "Day Change($)"=>"$187.11", "Day Change(%)"=>"0.28%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.28%", "Security Type"=>"Equity"}, {"Symbol"=>"PFE", "Name"=>"PFIZER INCORPORATED", "Quantity"=>"2,982", "Price"=>"$27.38", "Change"=>"-$0.03", "Market Value"=>"$81647.16", "Day Change($)"=>"-$89.46", "Day Change(%)"=>"-0.11%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.55%", "Security Type"=>"Equity"}, {"Symbol"=>"PM", "Name"=>"PHILIP MORRIS INTL INC", "Quantity"=>"900", "Price"=>"$93.42", "Change"=>"$0.29", "Market Value"=>"$84078.00", "Day Change($)"=>"$261.00", "Day Change(%)"=>"0.31%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.60%", "Security Type"=>"Equity"}, {"Symbol"=>"PG", "Name"=>"PROCTER & GAMBLE", "Quantity"=>"780", "Price"=>"$76.99", "Change"=>"-$0.05", "Market Value"=>"$60052.20", "Day Change($)"=>"-$39.00", "Day Change(%)"=>"-0.06%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.14%", "Security Type"=>"Equity"}, {"Symbol"=>"SU", "Name"=>"SUNCOR ENERGY INC NEW F", "Quantity"=>"2,160", "Price"=>"$31.27", "Change"=>"$0.35", "Market Value"=>"$67543.20", "Day Change($)"=>"$756.00", "Day Change(%)"=>"1.13%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.29%", "Security Type"=>"Equity"}, {"Symbol"=>"SYT", "Name"=>"SYNGENTA AG ADR FSPONSORED ADR 1 ADR REP 1/5 ORD", "Quantity"=>"900", "Price"=>"$84.66", "Change"=>"$0.62", "Market Value"=>"$76194.00", "Day Change($)"=>"$558.00", "Day Change(%)"=>"0.74%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.45%", "Security Type"=>"Equity"}, {"Symbol"=>"UPS", "Name"=>"UNITED PARCEL SERVICE B CLASS B", "Quantity"=>"810", "Price"=>"$82.94", "Change"=>"$0.33", "Market Value"=>"$67181.40", "Day Change($)"=>"$267.30", "Day Change(%)"=>"0.40%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.28%", "Security Type"=>"Equity"}, {"Symbol"=>"UTX", "Name"=>"UNITED TECHNOLOGIES CORP", "Quantity"=>"1,476", "Price"=>"$90.49", "Change"=>"$1.08", "Market Value"=>"$133563.24", "Day Change($)"=>"$1594.08", "Day Change(%)"=>"1.21%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.54%", "Security Type"=>"Equity"}, {"Symbol"=>"VZ", "Name"=>"VERIZON COMMUNICATIONS", "Quantity"=>"1,496", "Price"=>"$45.40", "Change"=>"$0.28", "Market Value"=>"$67918.40", "Day Change($)"=>"$418.88", "Day Change(%)"=>"0.62%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.29%", "Security Type"=>"Equity"}, {"Symbol"=>"V", "Name"=>"VISA INC CL A CLASS A", "Quantity"=>"450", "Price"=>"$159.43", "Change"=>"$1.99", "Market Value"=>"$71743.50", "Day Change($)"=>"$895.50", "Day Change(%)"=>"1.26%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"1.37%", "Security Type"=>"Equity"}, {"Symbol"=>"WAG", "Name"=>"WALGREEN COMPANY", "Quantity"=>"4,800", "Price"=>"$41.81", "Change"=>"$0.19", "Market Value"=>"$200688.00", "Day Change($)"=>"$912.00", "Day Change(%)"=>"0.46%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"3.82%", "Security Type"=>"Equity"}, {"Symbol"=>"VTA", "Name"=>"INVESCO DYNAMIC CREDIT OPPORTUNITIES FUND", "Quantity"=>"3,500", "Price"=>"$13.27", "Change"=>"-$0.03", "Market Value"=>"$46445.00", "Day Change($)"=>"-$105.00", "Day Change(%)"=>"-0.23%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.88%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"LQD", "Name"=>"ISHARES IBOXX INVESTOP IBOXX $ INVESTOP CORP BOND FUND", "Quantity"=>"940", "Price"=>"$119.77", "Change"=>"$0.08", "Market Value"=>"$112583.80", "Day Change($)"=>"$75.20", "Day Change(%)"=>"0.07%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"2.14%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"GSG", "Name"=>"ISHARES S&P GSCI CMDTY COMMODITY INDEXED TRUST", "Quantity"=>"100", "Price"=>"$33.20", "Change"=>"$0.11", "Market Value"=>"$3320.00", "Day Change($)"=>"$11.00", "Day Change(%)"=>"0.33%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.06%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"EFA", "Name"=>"ISHARES TR MSCI EAFE FD MSCI EAFE INDEX FUND", "Quantity"=>"9,050", "Price"=>"$58.49", "Change"=>"$0.83", "Market Value"=>"$529334.50", "Day Change($)"=>"$7511.50", "Day Change(%)"=>"1.44%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"10.07%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"PGF", "Name"=>"POWERSHS EXCH TRAD FD TRPOWERSHARES FINANCIAL PREFERRED PORTFOLIO", "Quantity"=>"21,800", "Price"=>"$18.45", "Change"=>"$0.01", "Market Value"=>"$402210.00", "Day Change($)"=>"$218.00", "Day Change(%)"=>"0.05%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"7.66%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"JNK", "Name"=>"SPDR BARCLAYS ETF HIGH YIELD VERY LIQUID INDEX", "Quantity"=>"1,000", "Price"=>"$40.83", "Change"=>"$0.05", "Market Value"=>"$40830.00", "Day Change($)"=>"$50.00", "Day Change(%)"=>"0.12%", "Reinvest Dividends?"=>"No", "Capital Gain"=>"--", "% of Account"=>"0.78%", "Security Type"=>"ETFs & Closed End Funds"}, {"Symbol"=>"Cash & Money Market", "Name"=>"", "Quantity"=>"", "Price"=>"", "Change"=>"", "Market Value"=>"$61622.39", "Day Change($)"=>"N/A", "Day Change(%)"=>"N/A", "Reinvest Dividends?"=>"--", "Capital Gain"=>"--", "% of Account"=>"1.17%", "Security Type"=>"Cash & Money Market"}, {"Symbol"=>"Total Market Value", "Name"=>"", "Quantity"=>"", "Price"=>"", "Change"=>"", "Market Value"=>"$5253988.67", "Day Change($)"=>nil, "Day Change(%)"=>nil, "Reinvest Dividends?"=>nil, "Capital Gain"=>nil, "% of Account"=>nil, "Security Type"=>nil}]

  portfolio = Portfolio.create!( :name => 'SLAT', :user_id => 1, :cash => 6000000 )
  puts 'New portfolio created: ' + portfolio.name + ' for ' + portfolio.user_id.to_s
  user = User.find_by_email('andy@denenberg.net')

positions[0..-3].each do |pos|
  position = purch( pos['Quantity'].gsub(',',''), pos['Symbol'].downcase, pos['Price'].gsub('$',''), "2013-02-23", user, "", portfolio )
  puts Stock.add_position ( position )
end

end
  
end

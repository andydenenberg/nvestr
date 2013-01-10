class Stock < ActiveRecord::Base
  belongs_to :user
  attr_accessible :portfolio, :purch_date, :purch_price, :symbol, :user_id

  require 'csv'

    def self.current(symbol)  
      url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=snl1d1t1c1ohgv&e=.csv"
      csv = CSV.parse(open(url).read)
  #    return 0, 0, 0, 0, 0, 0, 0 # csv
  #    return open(url).read.inspect # .gsub(/\r\n/,'')   
    end  

    def self.portfolio(port_name)
      portfolio = [ ]
      self.where(:portfolio => port_name).each do |p|        
        portfolio.push [ p.symbol, p.user.name, p.purch_price, p.purch_date ]
      end
      
      port = [ ]

      portfolio.each do |stock|

        purchase_price = stock[2]
        lookup = self.current(stock[0])

        company = lookup[0][1]
        symbol = lookup[0][0]
  			current_price = lookup[0][2]
  			change = lookup[0][5]


      stock.push ( (current_price.to_f - purchase_price) / purchase_price )
      stock.push company
      stock.push symbol
      stock.push current_price
      stock.push change
      port.push stock

      end
      port.sort_by!{|k| -k[4]}
    end
  
end

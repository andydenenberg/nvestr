class Stock < ActiveRecord::Base
  belongs_to :user
  attr_accessible :portfolio, :purch_date, :purch_price, :symbol, :user_id, :comments_attributes
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments, :allow_destroy => true
  
  validates_numericality_of :purch_price
  validates :purch_date, :presence => true

    def current(symbol)  
      self.current_price(symbol)['LastTrade']
#      url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=snl1d1t1c1ohgv&e=.csv"
#      csv = CSV.parse(open(url).read)
  #    return 0, 0, 0, 0, 0, 0, 0 # csv
  #    return open(url).read.inspect # .gsub(/\r\n/,'')   
    end  

    def self.portfolio(port_name)

      portfolio = [ ]
      self.where(:portfolio => port_name).each do |p|        
        lookup = Quote.current_price(p.symbol)

      # symbol-0, user.name-1, purch_price-2, purch_date-3, gain_loss-4, company-5, symbol-6, current_price-7, change-8, gain_loss-9

      portfolio.push [ p.symbol, p.user.name, p.purch_price, p.purch_date, (lookup['LastTrade'].to_f - p.purch_price) / p.purch_price, lookup['Name'], lookup['Symbol'], lookup['LastTrade'].to_f, lookup['Change'].to_f, lookup['LastTrade'].to_f - p.purch_price, (lookup['LastTrade'].to_f - p.purch_price) / p.purch_price ]

      end
      portfolio.sort_by!{|k| -k[4]}
    end
  
end

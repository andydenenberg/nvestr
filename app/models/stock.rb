class Stock < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio
  attr_accessible :name, :quantity, :portfolio_id, :purch_date, :purch_price, :symbol, :user_id, :comments_attributes
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments, :allow_destroy => true
  
  validates_numericality_of :purch_price
  validates :purch_date, :presence => true

    def current_price  
      Quote.current_price(self.symbol)['LastTrade'].to_f
    end  
    
    def todays_change
      quote = Quote.current_price(self.symbol)
      price_change = quote['Change'].to_f
      percent_change = price_change / quote['LastTrade'].to_f
      return price_change, percent_change
    end

    def position_cost
      self.quantity * self.purch_price
    end
    
    def position_value
      self.quantity * self.current_price
    end
    
    def position_gain_loss
      g_l = self.position_value - self.position_cost
      g_l_p = g_l / self.position_cost
      return g_l, g_l_p
    end
        
    def self.add_position(params)
      stock = Stock.new(params)
      portfolio = Portfolio.find(stock.portfolio)
      portfolio.cash -= (stock.purch_price * stock.quantity)
      if stock.save and portfolio.save 
        return stock
      else
        return false
      end    
    end
    
    def sell_position(shares)      
      self.quantity = self.quantity.to_i - shares.to_i
      p = Portfolio.find(self.portfolio_id)
      p.cash += shares.to_i * self.current_price
      self.save
      p.save
    end

    
#    def self.portfolio(port_name,sort_order,current_user)
#      Portfolio.where(:name => port_name, :user_id => current_user).first.rank_by_gain_loss(sort_order)     
#     portfolio = [ ]
#     stocks.each do |p|        
#       lookup = Quote.current_price(p.symbol)
#     # symbol-0, user.name-1, purch_price-2, purch_date-3, gain_loss-4, company-5, symbol-6, current_price-7, change-8, gain_loss-9
#     portfolio.push [ p.symbol,
#                      p.user.name,
#                      p.purch_price,
#                      p.purch_date,
#                      p.position_gain_loss, # (lookup['LastTrade'].to_f - p.purch_price) / p.purch_price, 
#                      lookup['Name'],
#                      p.symbol.upcase,
#                      p.current_price, # 7
#                      p.todays_change,
#                      p.position_gain_loss,
#                      p.position_gain_loss_percent,
#                      p.quantity, # 11
#                      p.id ]
#                      
#     end
#      if sort_order == 'overall'
#        portfolio.sort_by!{|k| -k[4]}
#      else
#        portfolio.sort_by!{|k| -k[4]}
#      end
#      return stocks
#    end
  
end

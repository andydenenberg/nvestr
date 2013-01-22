class Portfolio < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  has_many :stocks
  attr_accessible :cash, :stock_id, :user_id, :name
  
  validates_uniqueness_of :name, :scope => :user_id
  validates :name, :presence => true
  
  def current_value
    total = self.cash
    Stock.where(:portfolio_id => self.id).each { |stock| total += stock.position_value }
    return total    
  end
  
  def unrealized_gain_loss
    total = 0
    Stock.where(:portfolio_id => self.id).each { |stock| total += stock.position_gain_loss[0] }
    return total
  end
  
  def self.family_rank
    portfolios = [ ]
    (1..6).each do |user|
      p = self.where(:user_id => user, :name => 'Family Fun').first
      portfolios.push [ p.user_id, p.current_value ]
    end
    return portfolios.sort_by!{|k| -k[1]}
  end
  
  def rank_by_gain_loss(timeframe)
    stock_array = [ ]
      self.stocks.each do |stock|
      stock_array.push [ stock, stock.position_gain_loss[1], stock.todays_change[1] ]
    end

    if timeframe == 'today'
      stock_array.sort_by!{|k| -k[2]}
    else
      stock_array.sort_by!{|k| -k[1]}
    end
    stock_array.collect { |s| s[0] }  
    
  end
  
  
end

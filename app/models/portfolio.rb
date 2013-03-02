class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :stocks
  has_many :histories, :dependent => :destroy
  attr_accessible :cash, :user_id, :name
  
  validates_uniqueness_of :name, :scope => :user_id
  validates :name, :presence => true
  
  def current_value
    total = self.cash
    Stock.where(:portfolio_id => self.id).each { |stock| total += stock.position_value }
    return total    
  end
  
  def unrealized_gain_loss
    overall = 0
    today = 0
    Stock.where(:portfolio_id => self.id).each { |stock| today += stock.quantity * stock.todays_change[0] }
    Stock.where(:portfolio_id => self.id).each { |stock| overall += stock.position_gain_loss[0] }
    return overall, today
  end
  
  def self.family_rank
    portfolios = [ ]
    (1..6).each do |user|
      p = self.where(:user_id => user, :name => 'Family Fun').first
      portfolios.push [ p.user_id, p.current_value, p.cash ]
    end
    return portfolios.sort_by!{|k| -k[1]}
  end
  
  def rank_by_gain_loss(timeframe)
    stock_array = [ ]
      Stock.where("portfolio_id = #{self.id} and quantity > 0").each do |stock|
      stock_array.push [ stock, stock.position_gain_loss[1], stock.todays_change[1] ]
    end
    if timeframe == 'today'
      stock_array.sort_by!{|k| -k[2]}
    else
      stock_array.sort_by!{|k| -k[1]}
    end
    stock_array.collect { |s| s[0] }  
    
  end
  
  def time_values
    Array.new    
  end
  
  def self.display_rank
    colors = [ ]
    list = self.family_rank # [ user_id, current_value, cash ]
    seriesColors = [ '#4bb2c5', "#c5b47f", "#EAA228", "#579575", "#839557", "#958c12" ]
    list.each_with_index do |l,i|
      colors.push [ l[0], l[1], seriesColors[i] ]    
    end
    return colors
  end
  
end

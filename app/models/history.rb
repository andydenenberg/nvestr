class History < ActiveRecord::Base
  attr_accessible :cash, :portfolio_id, :value
  belongs_to :portfolio
end

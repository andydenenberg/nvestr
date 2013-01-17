class Portfolio < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  has_many :stocks
  attr_accessible :cash, :stock_id, :user_id, :name
  
  validates_uniqueness_of :name, :scope => :user_id
  validates :name, :presence => true
  
end

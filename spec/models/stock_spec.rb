require 'spec_helper'

describe Stock do
  before(:each) do
    @attr = { 
      :symbol => "ATMI",
      :purch_price => 21.0,
      :purch_date => '01/02/2013',
      :portfolio_id => 1,
      :quantity => 100
    }
  end
  
  it "should create a new instance given a valid attribute" do
    Stock.create!(@attr)
  end
end

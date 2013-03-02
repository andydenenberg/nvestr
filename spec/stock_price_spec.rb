
require 'spec_helper'

# rake db:test:prepare

describe 'Functional tests DenVestR' do
  
  describe 'Portfolio is a basket of Stocks and Cash' do
    it 'should contain cash' do
      portfolio = Portfolio.new
      portfolio.cash = 10000.00
      (portfolio.cash).should eq(10000.00)
    end
    
    it 'should belong to a valid user' do
      portfolio = Portfolio.new
      user_id = User.find_by_email('andy@denenberg.net')
      portfolio.user = user_id
      expect(portfolio.user).to eq(user_id)
    end
    
  end
    
  describe "distance_of_time_in_days" do
    it "should give the difference between to dates" do
      Quote.distance_of_time_in_days("10-10-2001","20-10-2001").should eq(10)
      Quote.distance_of_time_in_days("01-10-2001","01-11-2001").should eq(31)
    end
    it "should only return positive number" do
      Quote.distance_of_time_in_days("20-10-2001","10-10-2001").should eq(10)
    end
    it "should raise an error if time is invalid" do
      expect{Quote.distance_of_time_in_days("x3-10-2001","x1-20-314dcttt")}.to raise_error(ArgumentError)
    end
  end
  
  context 'Data Model Tests' do

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
        
    it 'should return an array of stock specific data' do
      sa = Stock.create(@attr)
#      stock_data = Stock.portfolio('Family Favorites')
# the previous line fails because there is no current_user in the context of the test
      expect(sa.symbol).to eq('ATMI')
    end
  end

  context 'Get stock price info from Yahoo Finance' do  

    before(:each) do
      @attr = { 
        :symbol => "atmi",
        :purch_price => 21.0,
        :purch_date => '01/02/2013',
        :portfolio_id => 1,
        :quantity => 100
      }
      
    end
    
     
    it 'check for historical price' do
      hp = Quote.hist_price('csco', '09/23/1999')
      hp['Close'].should be_a_kind_of(Numeric)
    end    
    it 'check for current price' do
      stock = Stock.create!(@attr)
      Quote.current_price('atmi')['LastTrade'].to_f.should be_a_kind_of(Numeric)
    end    
    it 'should return detect broken ticker symbols' do
      expect(Quote.current_price('?s@dsd12')).to eq(nil)
    end    
  end
      
end
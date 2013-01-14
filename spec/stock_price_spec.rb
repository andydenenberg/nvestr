

require 'spec_helper'

# rake db:test:prepare

describe 'Functional tests DenVestR' do
  
  context 'Data Model Tests' do

    before(:each) do
      @attr = { 
        :symbol => "ATMI",
        :purch_price => 21.0,
        :portfolio => 'Family Favorites'
      }
    end
    
    it "should create a new instance given a valid attribute" do
      Stock.create!(@attr)
    end
        
    it 'should return an array of stock specific data' do
      sa = Stock.create(@attr)
      stock_data = Stock.portfolio('Family Favorites')
      puts stock_data
      expect(sa.symbol).to eq('ATMI')
    end
  end

  context 'Get stock price info from Yahoo Finance' do  
    it 'check for historical price' do
      hp = Quote.hist_price('csco', '09/23/1999')
      hp['Close'].should be_a_kind_of(Numeric)
    end    
    it 'check for current price' do
      Quote.current_price('atmi')['LastTrade'].to_f.should be_a_kind_of(Numeric)
    end    
    it 'should return detect broken ticker symbols' do
      expect(Quote.current_price('?s@dsd12')['LastTrade'].to_f).to eq(0.0)
    end    
  end
      
end
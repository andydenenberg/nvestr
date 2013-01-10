  require 'csv'
  
  CONVERSIONS = [
    [1000, 'M'],
    [900, 'DM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I']
  ]

  def conversions_factors_for(in_arabic)
    CONVERSIONS.find { |arabic, _| arabic <= in_arabic }
  end

  def convert(in_arabic)
    return '' if in_arabic.zero?
    arabic, roman = conversions_factors_for(in_arabic)
    roman + convert(in_arabic - arabic)
  end
  
class Price
  def current(symbol)  
    url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=snl1d1t1c1ohgv&e=.csv"
    csv = CSV.parse(open(url).read)
#    return 0, 0, 0, 0, 0, 0, 0 # csv
#    return open(url).read.inspect # .gsub(/\r\n/,'')   
  end  
  
  def portfolio(portfolio)
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


#  s – Symbol
#  n – Name
#  l – Last Trade (with time)
#  l1 – Last Trade (without time)
#  d1 – Last Trade Date
#  t1 – Last Trade Time
#  k3 – Last Trade Size
#  c – Change and Percent Change
#  c1 – Change
#  p2 – Change in Percent
#  t7 – Ticker Trend
#  v – Volume
#  a2 – Average Daily Volume
#  i – More Info
#  t6 – Trade Links
#  b – Bid
#  b6 – Bid Size
#  a – Ask
#  a5 – Ask Size
#  p – Previous Close
#  o – Open
#  m – Day’s Range
#  w – 52 Week Range
#  j5 – Change from 52 Week Low
#  j6 – Percent Change from 52 Week Low
#  k4 – Change from 52 Week High
#  k5 – Percent Change from 52 Week High
#  e – Earnings/Share
#  r – P/E Ratio
#  s7 – Short Ratio
#  r1 – Dividend Pay Date
#  q – Ex-Dividend Date
#  d – Dividend/Share
#  y – Dividend Yield
#  f6 – Float Shares
#  j1 – Market Capitalization
#  t8 – 1 Year Target Price
#  e7 – EPS Est. Current Year
#  e8 – EPS Est. Next Year
#  e9 – EPS Est. Next Quarter
#  r6 – Price/EPS Est. Current Year
#  r7 – Price/EPS Est. Next Year
#  r5 – PEG Ratio
#  b4 – Book Value
#  p6 – Price/Book
#  p5 – Price/Sales
#  j4 – EBITDA
#  m3 – 50 Day Moving Average
#  m7 – Change from 50 Day Moving Average
#  m8 – Percent Change from 50 Day Moving Average
#  m4 – 200 Day Moving Average
#  m5 – Change from 200 Day Moving Average
#  m6 – Percent Change from 200 Day Moving Average
#  s1 – Shares Owned
#  p1 – Price Paid
#  c3 – Commission
#  v1 – Holdings Value
#  w1 – Day’s Value Change
#  g1 – Holdings Gain Percent
#  g4 – Holdings Gain
#  d2 – Trade Date
#  g3 – Annualized Gain
#  l2 – High Limit
#  l3 – Low Limit
#  n4 – Notes
#  k1 – Last Trade (Real-time) with Time
#  b3 – Bid (Real-time)
#  b2 – Ask (Real-time)
#  k2 – Change Percent (Real-time)
#  c6 – Change (Real-time)
#  v7 – Holdings Value (Real-time)
#  w4 – Day’s Value Change (Real-time)
#  g5 – Holdings Gain Percent (Real-time)
#  g6 – Holdings Gain (Real-time)
#  m2 – Day’s Range (Real-time)
#  j3 – Market Cap (Real-time)
#  r2 – P/E (Real-time)
#  c8 – After Hours Change (Real-time)
#  i5 – Order Book (Real-time)
#  x – Stock Exchange

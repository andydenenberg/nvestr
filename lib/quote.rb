  

module Quote
  require 'csv'
  require 'open-uri'

    def self.distance_of_time_in_days(from_time, to_time = 0)
      from_time = from_time.to_time if from_time.respond_to?(:to_time)
      to_time = to_time.to_time if to_time.respond_to?(:to_time)
      from_time, to_time = to_time, from_time if from_time > to_time
      distance_in_days = (((to_time - from_time).abs) / 86400).round
    end
    
    def self.current_price(symbol)
      symbol.gsub!(/[^a-z]/i, '') # remove any non alpha chars
      if symbol.length == 0  # if blank stuff with dummy string
        symbol = 'xyzxyz'
      end
      url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=snl1d1c1&e=.csv"
      data = CSV.parse(open(url).read)[0]
      current_price = { }
      ['Symbol', 'Name', 'LastTrade', 'LastTradeDate', 'Change' ].each_with_index { |title, i| current_price[title] = data[i] }
      current_price
    end  

    def self.hist_price(symbol,date)  
      comps = date.split('/')
      ds = "&a=#{comps[0].to_i-1}&b=#{comps[1]}&c=#{comps[2]}&d=#{comps[0].to_i-1}&e=#{comps[1]}&f=#{comps[2]}"
      url = "http://ichart.yahoo.com/table.csv?s=#{symbol}#{ds}&g=d&ignore=.csv"
  #    url = "http://ichart.yahoo.com/table.csv?s=#{symbol}&a=0&b=09&c=2013&d=0&e=09&f=2013&g=d&ignore=.csv"
      # http://code.google.com/p/yahoo-finance-managed/wiki/csvHistQuotesDownload
      resp = CSV.parse(open(url).read)
      hp = { }
      str = resp[1][0].split('-')
      hp['Date'] = str[1] + '/' + str[2] + '/' + str[0]
      resp[0][1..-1].each_with_index do |title, i|
        hp[title] = resp[1][i+1].to_f
      end
      return hp # hash with "Date", "Open", "High", "Low", "Close", "Volume", "Adj Close"    
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
  
  
  

module  Translog 

  def self.read_log
    lines = [ ]
    handle = File.open("log/portfolio_transaction.log","r")
      handle.lines.each do |line|
        lines.push line.chomp
      end
    handle.close
    return lines  
  end  
  
  def self.daily_snapshot
    Portfolio.all.each do |portfolio|
      hist = portfolio.histories.new
      hist.value = portfolio.current_value
      hist.cash = portfolio.cash
      hist.save
    end
      
    ss = Portfolio.family_rank
    text = 'Daily Snapshot: '
    text += ss.collect { |p| User.find(p[0]).name + ' = ' + p[1].to_s + ', '  }.join
    PostLogger.debug(text)
    pv = Portfolio.all.collect { |p| '[ "' + User.find(p.user_id).name + '", "' + p.name +  '", ' + p.current_value.to_s + ', ' + p.cash.to_s + ' ], ' }
    text = 'daily["portfolios"] = '
    text += pv.collect { |p| p }.join
    indexes = Quote.get_indexes
    text += '[ "nvestr_index", "S&P 500", ' + indexes[0]['LastTrade'] + ', ' + indexes[0]['Change'] + ' ], '  
    text += '[ "nvestr_index", "NASDAQ" , ' + indexes[1]['LastTrade'] + ' ' + indexes[0]['Change'] + ' ]'  
    PostLogger.info(text)
  end
  
  def self.parse_daily_snapshot(rank)
    s = self.read_log
    ds = s.collect { |l| l if l.include?('Daily Snapshot:') }.compact 
    arr = [ [],[],[],[],[],[] ]    
    ds.each_with_index do |line,i|
      cut = line.split('Daily Snapshot:')
      dt = cut[0].split(' ')
      time = dt[1] + ' ' + dt[2].delete(']')
      members = cut[1].split(',').collect { |mem| mem.split(' = ') }.collect { |m,n| [ m.delete(' '), n.to_f ] } # .sort_by! { |a,b| a }
        rank.each_with_index do |user,y|
          m = members.select { |name,value| name == user }
          arr[y][i] = [ time, m[0][1] ]
        end
    end
     return arr
     
  end

  def self.log_to_db # DEBUG
    rank = Portfolio.display_rank.collect { |p| p[0] }
    s = self.read_log
    ds = s.collect { |l| l if l.include?('Daily Snapshot:') }.compact 
    arr = [ [],[],[],[],[],[] ]  
    ds.each_with_index do |line,i|
      cut = line.split('Daily Snapshot:')
      dt = cut[0].split(' ')
      time = dt[1] + ' ' + dt[2].delete(']')
      members = cut[1].split(',').collect { |mem| mem.split(' = ') }.collect { |m,n| [ m.delete(' '), n.to_f ] } # .sort_by! { |a,b| a }
          rank.each_with_index do |user,y|
          m = members.select { |name,value| name == User.find(user).name }
          h = Portfolio.where(:user_id => user, :name => 'Family Fun' ).first.histories.new
          date = time[6] + time[7] + time[8] + time[9] + '/' + time[0] + time[1] + '/' + time[3] + time[4]
          h.created_at = Time.parse(date).getutc
          h.value = m[0][1]
          h.save
          arr[y][i] = [ time, m[0][1] ]
        end
    end
  end


def self.info_to_db # INFO
time = Time.parse('2013-02-28').getutc
info = [[ "Andy", "YCharts", 103095.28, 853 ], [ "Andy", "Andrew Slimmon", 99983.5, 60781 ], [ "Andy", "New Ideas", 100138.0, 71319 ], [ "Tim", "Risky", 90092.0, 30429 ], [ "Andy", "SLAT", 5250182.9799999995, 61622 ]]
info.each do |data|
  h = Portfolio.where(:user_id => User.find_by_name(data[0]), :name => data[1] ).first.histories.new
  h.created_at = time
  h.value = data[2]
  h.cash = data[3]
  h.save
end
time = Time.parse('2013-03-01').getutc
info = [[ "Andy", "YCharts", 103715.76, 853 ], [ "Andy", "Andrew Slimmon", 99903.0, 60781 ], [ "Andy", "New Ideas", 99781.5, 71319 ], [ "Tim", "Risky", 90362.0, 30429 ], [ "Andy", "SLAT", 5258649.3100000005, 61622 ]]
info.each do |data|
  h = Portfolio.where(:user_id => User.find_by_name(data[0]), :name => data[1] ).first.histories.new
  h.created_at = time
  h.value = data[2]
  h.cash = data[3]
  h.save
end
end  


 
  
  def self.db_daily_snapshot
    rank = Portfolio.display_rank.collect { |p| p[0] }
    arr = [ ]
    rank.each do |user|
      sub_arr = [ ]
      Portfolio.where(:user_id => user, :name => 'Family Fun' ).first.histories.each do |hist|
        sub_arr.push [ hist.created_at.strftime('%m-%d-%Y'), hist.value ]
      end
      arr.push sub_arr
    end
    return arr    
  end
  
end
  
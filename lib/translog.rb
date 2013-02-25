
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
    ss = Portfolio.family_rank
    text = 'Daily Snapshot: '
    text += ss.collect { |p| User.find(p[0]).name + ' = ' + p[1].to_s + ', '  }.join
    PostLogger.debug(text)
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
#      a = '[ '
#      ordered[0..-2].each do |m|
#        a += "[ '#{time}', #{m[0][1]} ],"   #[ time, m[0][1], m[0][0] ] # time, value, member_name
#      end
#        a += "[ '#{time}', '#{ordered.last[0][1]}' ] ],"
#        member += a
#    end
#    member = member[0..-2]
#    member += ' ]'
    end
     return arr
     
  end
  
end
  
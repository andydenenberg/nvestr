
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
  
  def self.parse_daily_snapshot
    s = self.read_log
    ds = s.collect { |l| l if l.include?('Daily Snapshot:') }.compact 
    member = [ ]
    ds.each do |line|
      cut = line.split('Daily Snapshot:')
      dt = cut[0].split(' ')
      time = dt[1] + ' ' + dt[2].delete(']')
      members = cut[1].split(',').collect { |mem| mem.split(' = ') }.collect { |m,n| [ m.delete(' '), n.to_f ] }.sort_by! { |a,b| a }
      a = [ ]
      members.each do |m|
        a.push [ time, m[1], m[0] ]
      end
      member.push a
    end
    return member
  end
  
end
  
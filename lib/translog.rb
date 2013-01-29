
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
  
  
end
  
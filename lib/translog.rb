
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
  
end
  
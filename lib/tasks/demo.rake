# On the Production System
#  mysqldump -u root -p -h localhost stc > stcBackup.sql
#  tar czvf /tmp/stc_public public/system

# On the Development System
# scp -i ~/.ssh/id_rsa.pub ubuntu@107.20.214.190:rails/stcBackup.sql .
# mysql -u root -p -h localhost stc < stcBackup.sql
# scp -i ~/.ssh/id_rsa.pub ubuntu@107.20.214.190:/tmp/stc_public .
# tar xzvf stc_public public/system

require "net/ssh"
require "net/scp"

namespace :demo do

  desc "Install production database to this copy. Warning: This will destroy your current data."
  task :daily_snapshot => :environment do
    Translog.daily_snapshot
  end
  
  desc "Copy with Portfolio Transaction Log"
  task :copy_file => :environment do
  # Establish the SSH session
  ssh = Net::SSH.start("nvestr.denenberg.net", 'ubuntu')
  # Use that session to generate an SCP object
  scp = ssh.scp
  # Download the file and run the code block each time a new chuck of data is received
  scp.download!("/home/ubuntu/rails/nvestr/log/portfolio_transaction.log", "/Users/andydenenberg/Documents/rails/nvestr/log") do |ch, name, received, total|
    # make sure to use absolute path with ruby scp - relative paths will not work like: "~/rails"

    # Calculate percentage complete and format as a two-digit percentage
    percentage = format('%.2f', received.to_f / total.to_f * 100) + '%'
    # Print on top of (replace) the same line in the terminal
    # - Pad with spaces to make sure nothing remains from the previous output
    # - Add a carriage return without a line feed so the line doesn't move down
    print "Saving to #{name}: Received #{received} of #{total} bytes" + " (#{percentage})               \r"
    # Print the output immediately - don't wait until the buffer fills up
    STDOUT.flush
  end
  puts "Fetch complete!"
  end

  desc "Install production database to this copy. Warning: This will destroy your current data."
  task :sync_from_prod=>:environment do
    
    puts "** WARNING ** You are about to replace your database and public/system folder!"
    
    url = 'nvestr.denenberg.net'
    app_database_name = 'nvestr'
    
    t = Time.now
    db_dump_file_name = "#{app_database_name}Backup#{t.to_i}.sql"
    tar_name = "#{t.to_i}.tar.gz"
    tmp_system = "/tmp/#{tar_name}"
    pub_sys = nil
    
    Net::SSH.start(url, 'ubuntu') do |ssh|
      puts "Dumping database remotely into /tmp/#{db_dump_file_name}"
      ssh.exec! "mysqldump -u root -h localhost #{app_database_name} > /tmp/#{db_dump_file_name}"
      puts 'db dump complete'
      puts "tar czvf #{tmp_system} public/system"
      pub_sys = ssh.exec! "tar czvf #{tmp_system} --directory ~/rails/#{app_database_name}/public/system"
      puts !pub_sys.include?('empty')
    end
    
    FileUtils.rm_rf tmp_system if File.exists? tmp_system
    Net::SCP.start(url, "ubuntu") do |scp|
      puts "Downloading database to your /tmp."
      scp.download("/tmp/#{db_dump_file_name}", "/tmp")
      
      puts "Downloading log/portfolio_transaction.log"
      scp.download("/home/ubuntu/rails/nvestr/log/portfolio_transaction.log", Rails.root.join('log','portfolio_transaction.log').to_s )
      # make sure to use absolute path with ruby scp - relative paths will not work like: "~/rails"
      if !pub_sys.include?('empty')  
        puts "Downloading system tar gz folder to your /tmp."
        scp.download(tmp_system, "/tmp")
      else
        puts 'No Public System files to copy...'
      end
    end
    
    Net::SSH.start(url, 'ubuntu') do |ssh|
      puts "Removing remote database dump"
      ssh.exec! "rm -f /tmp/#{db_dump_file_name}"

      puts "Removing remote tar gz file"
      ssh.exec! "rm -f #{tmp_system}"
      
    end
    if !pub_sys.include?('empty') 
      puts "Uncompressing system tar gz."
     `tar xzvf /tmp/#{tar_name} --directory public/system` 
    end
     
      puts "Loading database (The dump file remains in /tmp)"
      `mysql -u root -h localhost #{app_database_name} < /tmp/#{db_dump_file_name}`

  end

  
end



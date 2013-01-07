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
  task :sync_from_prod=>:environment do
    puts "** WARNING ** You are about to replace your database and public/system folder!"
    t = Time.now
    db_dump_file_name = "stcBackup#{t.to_i}.sql"
    tar_name = "#{t.to_i}.tar.gz"
    tmp_system = "/tmp/#{tar_name}"
    Net::SSH.start('stc.ospreypointcap.com', 'ubuntu') do |ssh|
      puts "Dumping database remotely into /tmp/#{db_dump_file_name}"
      ssh.exec! "mysqldump -u root -h localhost stc > /tmp/#{db_dump_file_name}"
      puts 'db dump complete'
      puts "tar czvf #{tmp_system} public/system"
      ssh.exec! "tar czvf #{tmp_system} --directory ~/rails/stc/public/ system"
    end
    FileUtils.rm_rf tmp_system if File.exists? tmp_system
    Net::SCP.start("stc.ospreypointcap.com", "ubuntu") do |scp|
      puts "Downloading database to your /tmp."
      scp.download("/tmp/#{db_dump_file_name}", "/tmp")
      puts "Downloading system tar gz folder to your /tmp."
      scp.download(tmp_system, "/tmp")
    end
    Net::SSH.start('stc.ospreypointcap.com', 'ubuntu') do |ssh|
      puts "Removing remote database dump"
      ssh.exec! "rm -f /tmp/#{db_dump_file_name}"

      puts "Removing remote tar gz file"
      ssh.exec! "rm -f #{tmp_system}"

    end
    puts "Uncompressing system tar gz."
    `tar xzvf /tmp/#{tar_name} --directory public/system`    
    puts "Loading database (The dump file remains in /tmp)"
    `mysql -u root -h localhost stc < /tmp/#{db_dump_file_name}`

  end
  
end



class FtpServer < Server

  def self.select_name
    "FTP Server"
  end
  
  def push_commit(commit)
    require 'net/ftp'
    
    # Iterate over the added, removed, and modified arrays
    ftp = Net::FTP.new self.hostname
    ftp.login self.username, self.password
    ftp.chdir commit.push.path
  end
  handle_asynchronously :push_commit
end

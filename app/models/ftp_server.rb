class FtpServer < Server

  def self.select_name
    "FTP Server"
  end
  
  def push_commit(commit)
    require 'net/ftp'
    
    # Iterate over the added, removed, and modified arrays
    ftp = Net::FTP.new self.hostname
    
    # Login with the supplied credentials
    ftp.login self.username, self.password
    
    # We assume the initial path already exists
    ftp.chdir commit.push.path
    
    # Now perform work
    commit.added.each do |path|
      # Traverse the path building directories as necessary
      # TODO Verify it is a directory
      path.split("/").each do |part|
        #ftp.mkdir(part) if ftp.dir.find_all {|obj| obj.match(/.*#{part}$/}
        ftp.mkdir(part) unless ftp.nlst.include? part
        ftp.chdir(part)
      end
      
      # Checkout the file to a temporary location
      
    end
    
    # Close the connection
    ftp.close
  end
  handle_asynchronously :push_commit
end

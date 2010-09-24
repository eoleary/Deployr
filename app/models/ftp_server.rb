class FtpServer < Server
  
  @connection = nil
  @current_env_path = nil
  
  def self.select_name
    "FTP Server"
  end
  
  #def push_commit(commit)
  #  require 'net/ftp'
    
    # Iterate over the added, removed, and modified arrays
  #  ftp = Net::FTP.new self.hostname
    
    # Login with the supplied credentials
  #  ftp.login self.username, self.password
    
    # We assume the initial path already exists
  #  ftp.chdir commit.push.path
    
    # Now perform work
  #  commit.added.each do |path|
      # Traverse the path building directories as necessary
      # TODO Verify it is a directory
  #    path.split("/").each do |part|
        #ftp.mkdir(part) if ftp.dir.find_all {|obj| obj.match(/.*#{part}$/}
  #      ftp.mkdir(part) unless ftp.nlst.include? part
  #      ftp.chdir(part)
  #    end
      
      # Checkout the file to a temporary location
      
  #  end
    
    # Close the connection
  #  ftp.close
  #end
  #handle_asynchronously :push_commit
  
  def connect env_path
    puts "Connected to #{self.hostname}, #{env_path}"
    @connection = Net::FTP.new self.hostname
    @connection.login self.username, self.password
    @current_env_path = env_path
  end
  
  def disconnect
    puts "Disconnected from #{self.hostname}"
    @connection.close
  end
  
  def remove_file dest_path
    puts "Removed file #{dest_path}"
    self.goto_root
    self.ch_dir dest_path
    @connection.delete File.basename(dest_path)
    
    # TODO removing a directory
  end
  
  def modify_file dest_path, src_path
    puts "Modified file #{dest_path}"
    self.goto_root
    self.ch_dir dest_path, true
    @connection.putbinaryfile src_path
  end
  
  def add_file dest_path, src_path
    puts "Added file #{dest_path}"
    self.goto_root
    self.ch_dir dest_path, true
    @connection.putbinaryfile src_path
  end
  
  def ch_dir dest_dir, force = false
    puts "Changing Directory #{dest_dir}"
    parts = dest_dir.split("/")
    parts.each do |part|
      @connection.chdir(part)
    end
  end
  
  def mk_dir path
    puts "Making Path #{path}"
  end
  
  def goto_root
    self.ch_dir "#{self.default_path}#{@current_env_path}"
  end
end

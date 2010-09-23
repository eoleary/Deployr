class Site < ActiveRecord::Base
  
  # Associations
  belongs_to :staging_server, :class_name => "Server"
  belongs_to :production_server, :class_name => "Server"
  has_many :gh_pushes, :through => :repository
  has_one :repository, :dependent => :destroy
  
  # Validations
  
  
  # Callbacks
  
  def after_create
    self.setup_repo
  end
  
  def after_destroy
    self.destroy_repo
  end
  
  # Helper methods
  
  def working_directory
    "#{DEPLOYR['working_directory']}/#{self.id}"
  end
  
  def git_repo
    require 'uri'
    "git@github.com:#{URI.parse(self.gh_url).path[1..-1]}.git"
  end
  
  def has_ref? ref
    repo = Grit::Repo.new(self.working_directory)
    local_branch = repo.branches.find {|branch| branch.name == ref}
    
    local_branch.nil?
  end
  
  # Delayed Jobs
  
  def setup_repo
    # Create the working directory
    FileUtils.mkdir(self.working_directory)
    
    # Clone the git repo into the working directory
    command = "git clone #{self.git_repo} #{self.working_directory}"
    output = system(command)
  end
  handle_asynchronously :setup_repo
  
  def destroy_repo(site)
    FileUtils.remove_dir(site.working_directory)
  end
  handle_asynchronously :destroy_repo
  
  def update_working_copy(push)
    if self.has_ref? push.short_ref
      command = "cd #{self.working_directory}; git pull; git checkout -t 'origin/#{push.short_ref}'"
      puts command
      output = system(command) 
    else
      command = "cd #{self.working_directory}; git checkout #{push.short_ref}; git pull origin #{push.short_ref}"
      output = system(command)
    end
  end
  
  def push_working_copy(push)
    # Make sure the working directory has the appropriate source
    command = "cd #{self.working_directory}; git checkout #{push.short_ref}"
    output = system(command)
    
    # Retrieve the server
    server = nil
    if push.short_ref.eql? "staging"
      server = self.staging_server
    elsif push.short_ref.eql? "production"
      server = self.production_server
    end
    
    # Contact the driver and perform the appropriate actions
    if not server.nil?
      server.connect
      push.commits.each do |commit|
        # Remove the appropriate files
        commit.removed.each do |path|
          server.remove_file path, "#{self.working_directory}#{path}"
        end unless commit.removed.nil?
        
        # Modify the appropriate files
        commit.modified.each do |path|
          server.modify_file path, "#{self.working_directory}#{path}"
        end unless commit.modified.nil?
        
        # Add the appropriate files
        commit.added.each do |path|
          server.add_file path, "#{self.working_directory}#{path}"
        end unless commit.added.nil?
      end
      server.disconnect
    end
  end
  
end

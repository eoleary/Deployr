class Site < ActiveRecord::Base
  
  # Associations
  belongs_to :staging_server, :class_name => "Server"
  belongs_to :production_server, :class_name => "Server"
  has_many :gh_pushes, :through => :repository
  has_one :repository
  
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
  
end

begin
  require 'delayed/tasks'
rescue LoadError
  STDERR.puts "Run `rake gems:install` to install delayed_job"
end

namespace :deployr do
  namespace :gh do
    desc "Posts the Github Sample payload to the commit endpoint"
    task :post => :environment do
      require 'uri'
      require 'net/http'
      
      payload = File.open("#{::Rails.root.to_s}/gh_sample.json").read
      req = Net::HTTP.new('127.0.0.1', 3000)
      puts req.post2('/commit', payload, {"Content-Type" => "application/json"}).body
    end
  end
  
  desc "Install the Deployr environment"
  task :install, :working_directory, :needs => :environment do |t, args|
    args.with_defaults(:working_directory => '/tmp/deployr')
    
    # Open the site config file for writing
    config = File.new("#{RAILS_ROOT}/config/deployr.yml", "w+");
    config.puts "working_directory: '#{args[:working_directory]}'"
    
    # Make the working deployr working directory
    FileUtils.mkdir(args[:working_directory])
    
    # Close the site config file
    config.close
  end
  
  desc "Remove the Deployr environment"
  task :uninstall => :environment do
    FileUtils.remove_dir DEPLOYR["working_directory"]
    
    # Delete the site config file
    FileUtils.remove "#{::Rails.root.to_s}/config/deployr.yml"
  end
end

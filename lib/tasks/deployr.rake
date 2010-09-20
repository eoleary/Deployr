namespace :deployr do
  namespace :gh do
    desc "Posts the Github Sample payload to the commit endpoint"
    task :post => :environment do
      require 'uri'
      require 'net/http'
      
      payload = File.open("#{RAILS_ROOT}/gh_sample.json").read
      req = Net::HTTP.new('127.0.0.1', 3000)
      puts req.post2('/commit', payload, {"Content-Type" => "application/json"}).body
    end
  end
end
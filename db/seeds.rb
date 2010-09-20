# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
server = Server.create(:hostname => "localhost", :username => "joe_user", :password => "example", :type => "SftpServer", :port => "22", :default_path => "/tmp/deployr")
Site.create(:domain => "github.com", :staging_server => server, :production_server => server, :staging_path => "/dev", :production_path => "/www", :gh_url => "http://github.com/defunkt/github")
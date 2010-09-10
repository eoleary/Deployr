class Site < ActiveRecord::Base
  
  # Associations
  belongs_to :staging_server, :class_name => "Server"
  belongs_to :production_server, :class_name => "Server"
  has_many :gh_pushes
  
  include ActionController::UrlWriter
  
  def after_create
    # When creating a new site we need to build the github postcommit url
    self.gh_url = "http://example.com" + commit_site_gh_pushes_path(self)
    self.save
  end
end

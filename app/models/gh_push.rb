class GhPush < ActiveRecord::Base
  
  serialize :payload
  
  # Active Record Associations
  belongs_to :repository
  has_many :commits
  
  def path
    case self.ref
    when "refs/head/staging" then self.repository.site.staging_server.default_path + self.repository.site.staging_path
    when "refs/head/production" then self.repository.site.production_server.default_path + self.repository.site.production_path
    else
      ""
    end
  end
  
  def after_create
    case self.ref
    when "refs/head/staging" then
      self.commits.each do |commit|
        self.site.staging_server.push_commit(commit)
      end
    when "refs/head/production" then
      self.commits.each do |commit|
        self.site.production_server.push_commit(commit)
      end
    end
  end
end

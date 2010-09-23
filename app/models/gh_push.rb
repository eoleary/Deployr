class GhPush < ActiveRecord::Base
  
  serialize :payload
  
  # Active Record Associations
  belongs_to :repository
  has_many :commits, :dependent => :destroy
  
  def path
    case self.ref
    when "refs/head/staging" then self.repository.site.staging_server.default_path + self.repository.site.staging_path
    when "refs/head/production" then self.repository.site.production_server.default_path + self.repository.site.production_path
    else
      ""
    end
  end
  
  def after_create
    if ["master", "staging", "production"].include? self.short_ref
      self.push_changes
    end
  end
  
  # Helpers
  def short_ref
    self.ref.split("/").pop
  end
  
  # Delayed Jobs
  def push_changes
    self.repository.site.update_working_copy self
    self.repository.site.push_working_copy self unless self.short_ref.eql? "master"
  end
  handle_asynchronously :push_changes
end

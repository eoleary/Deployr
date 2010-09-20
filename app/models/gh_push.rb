class GhPush < ActiveRecord::Base
  
  serialize :payload
  
  # Active Record Associations
  belongs_to :repository
  has_many :commits
end

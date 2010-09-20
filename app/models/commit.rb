class Commit < ActiveRecord::Base
  serialize :added
  serialize :removed
  serialize :modified
  
  # Active Record Associations
  belongs_to :author, :class_name => "GhUser"
  belongs_to :gh_push
end

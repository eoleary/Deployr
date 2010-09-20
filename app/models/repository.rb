class Repository < ActiveRecord::Base
  # Associations
  belongs_to :site
  belongs_to :gh_push
  belongs_to :owner, :class_name => "GhUser"
end

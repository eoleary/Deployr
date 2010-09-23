class Repository < ActiveRecord::Base
  # Associations
  belongs_to :site
  has_many :gh_pushes
  belongs_to :owner, :class_name => "GhUser"
end

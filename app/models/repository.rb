class Repository < ActiveRecord::Base
  # Associations
  belongs_to :site
  has_many :gh_pushes, :dependent => :destroy
  belongs_to :owner, :class_name => "GhUser"
end

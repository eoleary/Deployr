class Site < ActiveRecord::Base
  
  # Associations
  belongs_to :staging_server, :class_name => "Server"
  belongs_to :production_server, :class_name => "Server"
  has_many :gh_pushes, :through => :repository
  has_one :repository
end

class Site < ActiveRecord::Base
  
  # Associations
  belongs_to :staging_server, :class_name => "Server"
  belongs_to :production_server, :class_name => "Server"
  
end

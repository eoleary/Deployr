class Server < ActiveRecord::Base  
  
  has_many :production_sites, :class_name => "Site", :foreign_key => "production_server_id"
  has_many :staging_sites, :class_name => "Site", :foreign_key => "staging_server_id"
  
  # Fix name issues with link_to and form_for
  def self.model_name
    name = "server"
    name.instance_eval do
      def plural;   pluralize;   end
      def singular; singularize; end
      def human;    singularize; end # only for Rails 3
    end
    return name
  end
  
  # Select options containing all server descendants
  def self.select_options
    descendants.collect{ |c| [c.select_name, c.to_s] }
  end
  
  # Human friendly name
  def self.select_name
    "Generic Server"
  end
end

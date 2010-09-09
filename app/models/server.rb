class Server < ActiveRecord::Base

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
  
  def self.select_options
    descendants.collect{ |c| [c.select_name, c.to_s] }
  end
  
  def self.select_name
    "Generic Server"
  end
end

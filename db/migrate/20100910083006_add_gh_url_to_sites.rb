class AddGhUrlToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :gh_url, :string
  end

  def self.down
    remove_column :sites, :gh_url
  end
end

class AddSiteIdToRepositories < ActiveRecord::Migration
  def self.up
    add_column :repositories, :site_id, :integer
  end

  def self.down
    remove_column :repositories, :site_id
  end
end

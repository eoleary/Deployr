class AddGhIdToCommits < ActiveRecord::Migration
  def self.up
    add_column :commits, :gh_id, :string
  end

  def self.down
    remove_column :commits, :gh_id
  end
end

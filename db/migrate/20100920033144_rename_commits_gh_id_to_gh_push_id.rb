class RenameCommitsGhIdToGhPushId < ActiveRecord::Migration
  def self.up
    rename_column :commits, :gh_id, :gh_push_id
  end

  def self.down
    rename_column :commits, :gh_push_id, :gh_id
  end
end

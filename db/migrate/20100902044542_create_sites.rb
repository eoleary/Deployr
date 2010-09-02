class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :domain
      t.integer :staging_server_id
      t.integer :production_server_id
      t.string :staging_path
      t.string :production_path

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end

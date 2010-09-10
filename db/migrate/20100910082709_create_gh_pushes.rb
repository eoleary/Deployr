class CreateGhPushes < ActiveRecord::Migration
  def self.up
    create_table :gh_pushes do |t|
      t.integer :site_id
      t.text :payload
      t.string :ref

      t.timestamps
    end
  end

  def self.down
    drop_table :gh_pushes
  end
end

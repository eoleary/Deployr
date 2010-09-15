class CreateGhPushes < ActiveRecord::Migration
  def self.up
    create_table :gh_pushes do |t|
      t.string :before
      t.string :after
      t.string :ref
      t.integer :repository_id
      t.text :payload

      t.timestamps
    end
  end

  def self.down
    drop_table :gh_pushes
  end
end

class CreateCommits < ActiveRecord::Migration
  def self.up
    create_table :commits do |t|
      t.string :gh_id
      t.text :message
      t.datetime :timestamp
      t.string :url
      t.text :added
      t.text :removed
      t.text :modified
      t.integer :author_id

      t.timestamps
    end
  end

  def self.down
    drop_table :commits
  end
end

class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :hostname
      t.string :username
      t.string :password
      t.string :connection
      t.integer :port
      t.string :default_path

      t.timestamps
    end
  end

  def self.down
    drop_table :servers
  end
end

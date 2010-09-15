class CreateGhUsers < ActiveRecord::Migration
  def self.up
    create_table :gh_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :gh_users
  end
end

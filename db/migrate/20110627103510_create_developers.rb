class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :slug
      t.integer :fid

      t.timestamps
    end
    
    add_index :developers, :slug, :unique => true
    add_index :developers, :fid, :unique => true
  end
end

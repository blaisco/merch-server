class CreateFranchises < ActiveRecord::Migration
  def change
    create_table :franchises do |t|
      t.string :name
      t.string :slug
      t.integer :fid

      t.timestamps
    end
    
    add_index :franchises, :slug, :unique => true
    add_index :franchises, :fid, :unique => true
  end
end

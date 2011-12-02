class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :slug
      t.integer :fid

      t.timestamps
    end
    
    add_index :platforms, :slug, :unique => true
    add_index :platforms, :fid, :unique => true
  end
end

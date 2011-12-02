class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name
      t.string :slug
      t.integer :fid

      t.timestamps
    end
    
    add_index :genres, :slug, :unique => true
    add_index :genres, :fid, :unique => true
  end
end

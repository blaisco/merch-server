class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :slug
      t.string :aliases
      t.date :release_date
      t.integer :fid
      
      t.timestamps
    end
    
    add_index :games, :slug, :unique => true
    add_index :games, :fid, :unique => true
  end
end

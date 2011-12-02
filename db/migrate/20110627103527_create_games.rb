class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :franchise
      t.string :name
      t.string :slug
      t.integer :fid
      t.date :release_date

      t.timestamps
    end
    
    add_index :games, :slug, :unique => true
    add_index :games, :fid, :unique => true
  end
end

class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :game
      t.references :franchise
      t.references :developer
      t.references :merchant
      t.string :slug
      t.string :name
      t.string :url
      t.text :description
      t.integer :status, :limit => 1
      t.string :checksum, :limit => 40
      t.datetime :checksum_changed_at

      t.timestamps
    end
    add_index :products, :slug, :unique => true
    add_index :products, :status
    add_index :products, [ :status, :updated_at ]
  end
end

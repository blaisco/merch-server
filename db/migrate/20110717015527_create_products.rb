class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :game
      t.references :franchise
      t.references :product_type
      t.references :merchant
      t.string :slug
      t.string :name
      t.string :url
      t.string :short_desc
      t.text :description
      t.text :features

      t.timestamps
    end
    add_index :products, :slug, :unique => true
    add_index :products, :game_id
    add_index :products, :product_type_id
  end
end

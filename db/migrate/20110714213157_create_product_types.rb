class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :slug
      t.decimal :rank, :precision => 3, :scale => 1

      t.timestamps
    end
    
    add_index :product_types, :slug, :unique => true
    add_index :product_types, :rank
  end
end

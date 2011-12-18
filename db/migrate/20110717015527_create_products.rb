class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :merchandisable, :polymorphic => true
      t.references :product_type
      t.references :merchant
      t.string :slug
      t.string :name
      t.string :url
      t.string :summary
      t.text :description
      t.string :status
      t.string :hash, :limit => 40
      t.datetime :hash_changed_at

      t.timestamps
    end
    add_index :products, :slug, :unique => true
    add_index :products, [ :merchandisable_type, :merchandisable_id]
    add_index :products, :product_type_id
    add_index :products, :merchant_id
    add_index :products, :status
    add_index :products, :hash
  end
end

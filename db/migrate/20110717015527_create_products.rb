class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :merchandisable, :polymorphic => true
      t.references :merchant
      t.string :slug
      t.string :name
      t.string :url
      t.text :description
      t.integer :status
      t.string :checksum, :limit => 40
      t.datetime :checksum_changed_at

      t.timestamps
    end
    add_index :products, :slug, :unique => true
    add_index :products, [ :merchandisable_type, :merchandisable_id]
    add_index :products, :merchant_id
    add_index :products, :status
    add_index :products, :checksum
  end
end

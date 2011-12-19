class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|
      t.references :product
      t.string :size # size is a reserved word in ruby
      t.string :color
      t.boolean :in_stock

      t.timestamps
    end
    add_index :variations, :product_id
  end
end

class CreateTypifications < ActiveRecord::Migration
  def change
    create_table :typifications do |t|
      t.references :product
      t.references :product_type

      t.timestamps
    end
    add_index :typifications, :product_id
    add_index :typifications, :product_type_id
  end
end

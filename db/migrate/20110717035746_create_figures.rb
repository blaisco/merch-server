class CreateFigures < ActiveRecord::Migration
  def change
    create_table :figures do |t|
      t.references :variation
      t.integer :price_cents
      t.integer :amount_saved_cents
      # t.integer :shipping_cost_cents
      t.string :currency

      t.timestamps
    end
  end
end

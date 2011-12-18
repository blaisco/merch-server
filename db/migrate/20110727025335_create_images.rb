class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :product
      t.string :size
      t.string :original_url
      t.string :path
      t.string :hash, :limit => 40

      t.timestamps
    end
    
    add_index :images, :product_id
  end
end

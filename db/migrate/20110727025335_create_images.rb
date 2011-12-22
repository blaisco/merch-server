class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :product
      t.string :original_url
      t.string :checksum, :limit => 40

      t.timestamps
    end
    
    add_index :images, :product_id
    add_index :images, :checksum
  end
end

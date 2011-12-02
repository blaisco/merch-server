class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :product
      t.string :url
      t.string :url_75px
      t.string :url_160px
      t.string :url_500px

      t.timestamps
    end
    
    add_index :images, :product_id
  end
end

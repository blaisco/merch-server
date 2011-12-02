class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :slug
      t.string :url

      t.timestamps
    end
    
    add_index :merchants, :slug, :unique => true
  end
end

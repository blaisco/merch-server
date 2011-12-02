class CreateFranchises < ActiveRecord::Migration
  def change
    create_table :franchises do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    
    add_index :franchises, :slug, :unique => true
  end
end

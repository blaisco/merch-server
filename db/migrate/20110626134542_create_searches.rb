class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query
      t.integer :num_results
      t.string :ip_address

      t.timestamps
    end
  end
end

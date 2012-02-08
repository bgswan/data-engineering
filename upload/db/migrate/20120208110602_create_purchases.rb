class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :id
      t.integer :item_id
      t.integer :purchaser_id
      t.integer :quantity

      t.timestamps
    end
  end
end

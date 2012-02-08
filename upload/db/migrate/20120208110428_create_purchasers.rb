class CreatePurchasers < ActiveRecord::Migration
  def change
    create_table :purchasers do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end

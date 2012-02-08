class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :id
      t.decimal :price
      t.string :description
      t.integer :merchant_id

      t.timestamps
    end
  end
end

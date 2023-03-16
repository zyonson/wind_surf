class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :store_name
      t.string :address
      t.string :phone_number
      t.string :boat_house
      t.integer :price
      t.string :day
      t.string :time

      t.timestamps
    end
  end
end

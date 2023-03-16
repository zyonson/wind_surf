class AddPrefecturesToStores < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :prefecture, :string
  end
end

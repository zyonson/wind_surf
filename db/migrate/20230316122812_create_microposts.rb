class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table :microposts do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
    add_index :microposts, [:store_id, :created_at]
  end
end

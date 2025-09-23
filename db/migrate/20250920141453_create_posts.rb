class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :region, null: false
      t.string :shop_name, null: false
      t.text :body
      t.integer :rating, null: false

      t.timestamps
    end
  end
end

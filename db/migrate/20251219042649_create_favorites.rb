class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      # アプリケーション層（Railsバリデーション）
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    # データベース層（DBインデックス）
    add_index :favorites, [:user_id, :post_id], unique: true
  end
end

class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :place_id, null: false #Google Place APIのID #API成功時は必ずnullにならない
      t.string :name, null: false #店名
      t.string :address # 住所
      t.string :google_map_url # マップリンク
      t.text :business_hours #営業時間
      t.string :phone_number #電話

      t.timestamps
    end
    # このテーブルの同じplaice_idは保存されない（同じ店舗が検索されたら前保存したものを使う）
    add_index :shops, :place_id, unique: true
  end
end

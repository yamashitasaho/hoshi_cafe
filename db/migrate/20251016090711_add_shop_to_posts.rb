class AddShopToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :shop, null: true, foreign_key: true
    # shop_idはAPIで見つからない場合があるのでnull: trueに修正
  end
end

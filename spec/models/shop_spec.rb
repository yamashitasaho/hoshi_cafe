require 'rails_helper'

RSpec.describe Shop, type: :model do
    describe 'バリデーションチェック' do
        # 成功パターン
        it '設定したすべてのバリデーションが機能しているか' do
            shop = create(:shop)
            expect(shop).to be_valid
            expect(shop.errors).to be_empty
        end

        # 失敗パターン
        it 'place_idがない場合バリデーションエラーになるか' do
          shop = build(:shop, place_id: '')
          expect(shop).to be_invalid
        end

        it 'place_idが重複している場合バリデーションエラーになるか' do
            create(:shop, place_id: 'duplicate')
            shop = build(:shop, place_id: 'duplicate')
            expect(shop).to be_invalid
        end

        it 'nameがない場合バリデーションエラーになるか' do
          shop = build(:shop, name: '')
          expect(shop).to be_invalid
        end
    end
end

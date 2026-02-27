require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーションチェック' do
    # 成功パターン
    it '設定したすべてのバリデーションが機能しているか' do
      favorite = create(:favorite)
      expect(favorite).to be_valid
      expect(favorite.errors).to be_empty
    end

    # 失敗パターン
    it '同じユーザーが同じ投稿を重複してお気に入りできないか' do
      favorite = create(:favorite)
      duplicate = build(:favorite, user: favorite.user, post: favorite.post)
      expect(duplicate).to be_invalid
    end
  end
end

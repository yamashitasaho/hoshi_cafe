require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションチェック' do
    # 成功パターン
    it '設定したすべてのバリデーションが機能しているか' do
        post = create(:post)
        expect(post).to be_valid
        expect(post.errors).to be_empty
    end

    # 失敗パターン
    it 'regionがない場合バリデーションエラーになるか' do
        post = build(:post, region: '')
        expect(post).to be_invalid
    end

    it 'regionが5文字超の場合バリデーションエラーになるか' do
        post = build(:post, region: 'あ' * 6)
        expect(post).to be_invalid
    end

    it 'shop_nameがない場合バリデーションエラーになるか' do
        post = build(:post, shop_name: '')
        expect(post).to be_invalid
    end

    it 'shop_nameが28文字超の場合バリデーションエラーになるか' do
        post = build(:post, shop_name: 'あ' * 29)
        expect(post).to be_invalid
    end

    it 'ratingが0の場合バリデーションエラーになるか' do
        post = build(:post, rating: 0)
        expect(post).to be_invalid
      end

    it 'ratingが6の場合バリデーションエラーになるか' do
      post = build(:post, rating: 6)
      expect(post).to be_invalid
    end

    it 'bodyが500超の場合バリデーションエラーになるか' do
        post = build(:post, body: 'a' * 501)
        expect(post).to be_invalid
    end

    it 'is_prがnilの場合バリデーションエラーになるか' do
        post = build(:post, is_pr: nil)
        expect(post).to be_invalid
    end
  end
end

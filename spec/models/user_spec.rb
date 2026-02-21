require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'バリデーションチェック' do
        # 成功パターン
        it '設定したすべてのバリデーションが機能しているか' do
            # user= User.new(username: 'valid_user', email: 'test@example.com', password: 'password')
            user = create(:user)
            expect(user).to be_valid
            expect(user.errors).to be_empty
        end

        # 失敗パターン
        it 'usernameがない場合バリデーションエラーになるか' do
          user = build(:user, username: '')
          expect(user).to be_invalid
        end

        it 'usernameが重複している場合バリデーションエラーになるか' do
            create(:user, username: 'duplicate')
            user = build(:user, username: 'duplicate')
            expect(user).to be_invalid
          end
        # 最初の create でDBに保存して、次の build で同じusernameのユーザーを作って重複チェックしています

        it 'usernameに使えない文字が含まれる場合バリデーションエラーになるか' do
            user = build(:user, username: 'invalid user!')
            expect(user).to be_invalid
        end
        # スペースや!はエラー

        it 'usernameが3文字未満の場合バリデーションエラーになるか' do
          user = build(:user, username: 'ab')
          expect(user).to be_invalid
        end

        it 'usernameが20文字超の場合バリデーションエラーになるか' do
          user = build(:user, username: 'a' * 21)
          expect(user).to be_invalid
        end

        it 'regionが5文字超の場合バリデーションエラーになるか' do
            user = build(:user, region: 'あ' * 6)
            expect(user).to be_invalid
        end

        it 'introductionが150文字超の場合バリデーションエラーになるか' do
            user = build(:user, introduction: 'あ' * 151)
            expect(user).to be_invalid
        end
    end
end

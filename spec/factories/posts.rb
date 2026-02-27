FactoryBot.define do
    factory :post do
        association :user # userも自動生成
        region { '京都' }
        shop_name { 'テストカフェ' }
        rating { 3 }
        body { '美味しいです！' }
        is_pr { false }
    end
end

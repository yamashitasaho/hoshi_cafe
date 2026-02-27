FactoryBot.define do
    factory :shop do
        sequence(:place_id) { |n| "place_id#{n}" }
        name { 'テスト店舗' }
    end
end

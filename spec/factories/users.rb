FactoryBot.define do
    factory :user do
        sequence(:username) { |n| "valid_user#{n}" }
        sequence(:email) { |n| "test#{n}@example.com" }
        password { 'password' }
    end
end

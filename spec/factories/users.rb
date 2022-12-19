# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { |n| n }
    # name { Faker::Name.name }
    # username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 10) }

    trait :customer do
      role { 0 }
    end

    trait :school_manager do
      role { 1 }
    end

    trait :area_manager do
      role { 2 }
    end

    trait :admin do
      role { 3 }
    end

    factory :customer_user, traits: [:customer]
    factory :sm_user, traits: [:school_manager]
    factory :am_user, traits: [:area_manager]
    factory :admin_user, traits: [:admin]
  end
end
# frozen_string_literal: true

FactoryBot.define do
  factory :school do
    area
    name { Faker::Address.city }
  end
end

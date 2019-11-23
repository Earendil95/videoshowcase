# frozen_string_literal: true

FactoryBot.define do
  factory :episode do
    title { Faker::Commerce.product_name }
    plot { Faker::Lorem.paragraph(sentence_count: 2) }
    number { rand(1..24) }
    season
  end
end

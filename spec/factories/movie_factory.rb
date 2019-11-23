# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Commerce.product_name }
    plot { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end

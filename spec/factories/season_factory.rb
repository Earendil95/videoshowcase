# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    title { Faker::Commerce.product_name }
    plot { Faker::Lorem.paragraph(sentence_count: 2) }
    number { rand(1..8) }

    transient do
      episodes_count { 0 }
    end

    after(:create) do |season, evaluator|
      evaluator.episodes_count.times.with_index do |number|
        create :episode, season: season, number: number + 1
      end
    end
  end
end

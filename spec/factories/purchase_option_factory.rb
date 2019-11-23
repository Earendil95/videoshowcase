# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_option do
    price { rand(1..599) }
    quality { %w[sd hd].sample }
    content { association(:movie) }
  end
end

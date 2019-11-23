# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email_#{ENV['TEST_ENV_NUMBER'] || 1}_#{n}@factory.com"
  end

  factory :user do
    email
  end
end

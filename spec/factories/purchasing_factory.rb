# frozen_string_literal: true

FactoryBot.define do
  factory :purchasing do
    user
    purchase_option
    expires_at { 2.days.from_now }

    after(:build) do |purchasing|
      purchasing.content ||= purchasing.purchase_option.content
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    kind { :normal }

    email { Faker::Internet.email }

    password { Faker::Internet.password }

    reset_password_token { SecureRandom.base58 }

    notifications_count { 0 } # TODO: fix

    trait :oauth do
      kind { :oauth }

      email { nil }

      password { nil }
    end
  end
end

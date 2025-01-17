# frozen_string_literal: true

FactoryBot.define do
  factory :eve_system, class: Eve::System do
    sequence(:constellation_id)

    name { Faker::Lorem.word }

    security_class { "B" }

    security_status { 0.8583240509033203 }

    sequence(:star_id)

    sequence(:system_id)
  end
end

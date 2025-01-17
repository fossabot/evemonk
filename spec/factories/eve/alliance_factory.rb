# frozen_string_literal: true

FactoryBot.define do
  factory :eve_alliance, class: Eve::Alliance do
    sequence(:alliance_id)

    sequence(:creator_corporation_id)

    sequence(:creator_id)

    date_founded { Time.zone.now }

    sequence(:executor_corporation_id)

    sequence(:faction_id)

    name { Faker::Lorem.word }

    ticker { Faker::Lorem.word.upcase }

    corporations_count { 0 } # TODO: fix

    characters_count { 0 } # TODO: fix
  end
end

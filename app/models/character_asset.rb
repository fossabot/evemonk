# frozen_string_literal: true

class CharacterAsset < ApplicationRecord
  belongs_to :character

  belongs_to :type,
    class_name: "Eve::Type",
    primary_key: "type_id",
    foreign_key: "type_id",
    optional: true
end

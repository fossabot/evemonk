# frozen_string_literal: true

module Eve
  class Stargate < ApplicationRecord
    has_paper_trail

    belongs_to :system, primary_key: "system_id", optional: true

    # has_one :stargate_destination, primary_key: :stargate_id, foreign_key: :from_stargate_id, dependent: :destroy

    # belongs_to :type, optional: true
  end
end

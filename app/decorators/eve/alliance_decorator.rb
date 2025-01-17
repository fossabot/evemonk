# frozen_string_literal: true

module Eve
  class AllianceDecorator < ApplicationDecorator
    include ActionView::Helpers::NumberHelper

    decorates_associations :creator_corporation, :creator,
      :executor_corporation, :faction, :alliance_corporations, :corporations,
      :characters

    def date_founded
      object.date_founded.iso8601
    end

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=32&tenant=tranquility"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=64&tenant=tranquility"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=128&tenant=tranquility"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=256&tenant=tranquility"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=512&tenant=tranquility"
    end

    def formatted_corporations_count
      number_with_delimiter(corporations_count, delimiter: " ")
    end

    def formatted_characters_count
      number_with_delimiter(characters_count, delimiter: " ")
    end
  end
end

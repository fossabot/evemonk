# frozen_string_literal: true

class CharacterAssetsJob < ActiveJob::Base
  queue_as :default

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError

  def perform(character_id)
    CharacterAssetsImporter.new(character_id).import
  end
end

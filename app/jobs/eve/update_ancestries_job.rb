# frozen_string_literal: true

module Eve
  class UpdateAncestriesJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::AncestriesImporter.new(locale).import
      end
    end
  end
end

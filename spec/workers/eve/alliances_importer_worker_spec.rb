# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    before do
      #
      # Eve::AlliancesImporter.new.import
      #
      expect(Eve::AlliancesImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end

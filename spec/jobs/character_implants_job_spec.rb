# frozen_string_literal: true

require "rails_helper"

describe CharacterImplantsJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:character_id) { double }

    before do
      #
      # CharacterImplantsImporter.new(character_id).import
      #
      expect(CharacterImplantsImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    subject { described_class.new }

    specify { expect { subject.perform(character_id) }.not_to raise_error }
  end
end

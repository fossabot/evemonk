# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalTypesImporter do
  describe "#import" do
    let(:type_id) { double }

    before do
      #
      # Eve::Type.pluck(:type_id) => [type_id]
      #
      expect(Eve::Type).to receive(:pluck).with(:type_id).and_return([type_id])
    end

    before { expect(Eve::TypeImporterWorker).to receive(:perform_async).with(type_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end

# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#date_founded" do
    context "when date_founded is empty" do
      let(:eve_corporation) do
        build(:eve_corporation,
          date_founded: nil)
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.date_founded).to eq(nil) }
    end

    context "when date_founded is present" do
      let(:eve_corporation) do
        build(:eve_corporation,
          date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.date_founded).to eq("2015-05-03T19:45:17Z") }
    end
  end

  describe "#description" do
    let(:eve_corporation) do
      build(:eve_corporation,
        description: "<b>Test</b>")
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  describe "#icon_tiny" do
    let(:eve_corporation) do
      build(:eve_corporation,
        corporation_id: 1_344_654_522)
    end

    subject { eve_corporation.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=32&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/corporations/1344654522/logo?size=32&tenant=tranquility") }
    end
  end

  describe "#icon_small" do
    let(:eve_corporation) do
      build(:eve_corporation,
        corporation_id: 1_344_654_522)
    end

    subject { eve_corporation.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=64&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/corporations/1344654522/logo?size=64&tenant=tranquility") }
    end
  end

  describe "#icon_medium" do
    let(:eve_corporation) do
      build(:eve_corporation,
        corporation_id: 1_344_654_522)
    end

    subject { eve_corporation.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=128&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/corporations/1344654522/logo?size=128&tenant=tranquility") }
    end
  end

  describe "#icon_large" do
    let(:eve_corporation) do
      build(:eve_corporation,
        corporation_id: 1_344_654_522)
    end

    subject { eve_corporation.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=256&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/corporations/1344654522/logo?size=256&tenant=tranquility") }
    end
  end

  describe "#tax_rate" do
    let(:eve_corporation) do
      build(:eve_corporation,
        tax_rate: 0.99)
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.tax_rate).to eq("0.99") }
  end

  describe "#formatted_member_count" do
    context "when number is 3" do
      let(:eve_corporation) do
        build(:eve_corporation,
          member_count: 111)
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.formatted_member_count).to eq("111") }
    end

    context "when number is 6" do
      let(:eve_corporation) do
        build(:eve_corporation,
          member_count: 111_222)
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.formatted_member_count).to eq("111,222") }
    end
  end
end

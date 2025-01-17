# frozen_string_literal: true

require "rails_helper"

describe EmploymentHistoriesController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index" do
    let(:current_user) { instance_double(User) }

    before { sign_in(current_user) }

    before do
      #
      # current_user.characters
      #             .includes(character_corporation_histories: :corporation)
      #             .find_by!(character_id: params[:character_id])
      #             .decorate
      #
      expect(current_user).to receive(:characters) do
        double.tap do |a|
          expect(a).to receive(:includes).with(character_corporation_histories: :corporation) do
            double.tap do |b|
              expect(b).to receive(:find_by!).with(character_id: "1") do
                double.tap do |c|
                  expect(c).to receive(:decorate)
                end
              end
            end
          end
        end
      end
    end

    before { get :index, params: {character_id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end
end

# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CorporationsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::CorporationsSearcher.new(params[:q])
        #                          .search
        #                          .page(params[:page])
        #                          .decorate
        #
        expect(Eve::CorporationsSearcher).to receive(:new).with("search string") do
          double.tap do |a|
            expect(a).to receive(:search) do
              double.tap do |b|
                expect(b).to receive(:page).with("1") do
                  double.tap do |c|
                    expect(c).to receive(:decorate)
                  end
                end
              end
            end
          end
        end
      end

      before { get :index, params: {format: :json, page: "1", q: "search string"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe "#show" do
    context "with supported content type" do
      before do
        #
        # Eve::Corporation
        #   .find_by!(corporation_id: params[:id])
        #   .decorate
        #
        expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: "98005120") do
          double.tap do |a|
            expect(a).to receive(:decorate)
          end
        end
      end

      before { get :show, params: {id: "98005120", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when not supported accept type" do
      before { get :show, params: {id: "98005120", format: :html} }

      it { should respond_with(:not_acceptable) }
    end

    context "when corporation not found" do
      before do
        #
        # Eve::Corporation
        #   .find_by!(corporation_id: params[:id]) # => ActiveRecord::RecordNotFound
        #
        expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: "98005120")
          .and_raise(ActiveRecord::RecordNotFound)
      end

      before { get :show, params: {id: "98005120", format: :json} }

      it { should respond_with(:not_found) }
    end
  end
end

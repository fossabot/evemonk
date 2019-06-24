# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationCharactersController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#index' do
    context 'with supported content type' do
      let(:corporation) { instance_double(Eve::Corporation) }

      before do
        #
        # subject.policy_scope(::Eve::Corporation)
        #        .find_by!(corporation_id: params[:corporation_id]) # => corporation
        #
        expect(subject).to receive(:policy_scope).with(Eve::Corporation) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(corporation_id: '12345')
                                           .and_return(corporation)
          end
        end
      end

      before do
        #
        # subject.policy_scope(Eve::Character).where(corporation: @corporation)
        #                                     .includes(:alliance,
        #                                               :ancestry,
        #                                               :bloodline,
        #                                               :corporation,
        #                                               :faction,
        #                                               :race)
        #                                     .page(params[:page])
        #
        expect(subject).to receive(:policy_scope).with(Eve::Character) do
          double.tap do |a|
            expect(a).to receive(:where).with(corporation: corporation) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance,
                                                     :ancestry,
                                                     :bloodline,
                                                     :corporation,
                                                     :faction,
                                                     :race) do
                  double.tap do |c|
                    expect(c).to receive(:page).with('1')
                  end
                end
              end
            end
          end
        end
      end

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

      before { get :index, params: { format: :json, page: '1', corporation_id: '12345' } }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context 'when not supported accept type' do
      before { get :index, params: { corporation_id: '12345', format: :html } }

      it { should respond_with(:not_acceptable) }
    end

    context 'when corporation not found' do
      before do
        #
        # subject.policy_scope(::Eve::Corporation)
        #        .find_by!(corporation_id: params[:corporation_id])
        #
        expect(subject).to receive(:policy_scope).with(Eve::Corporation) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(corporation_id: '12345')
                                           .and_raise(ActiveRecord::RecordNotFound)
          end
        end
      end

      before { get :index, params: { corporation_id: '12345', format: :json } }

      it { should respond_with(:not_found) }
    end
  end
end
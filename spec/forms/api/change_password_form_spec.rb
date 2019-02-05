# frozen_string_literal: true

require 'rails_helper'

describe Api::ChangePasswordForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  xit { should validate_presence_of(:old_password) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_presence_of(:password) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_presence_of(:password_confirmation) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_confirmation_of(:password) }

  it { should delegate_method(:id).to(:session) }

  it { should delegate_method(:token).to(:session) }

  describe '#save' do
    context 'when everything ok' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'old_password') }

      let(:params) do
        {
          old_password: 'old_password',
          password: 'new_password',
          password_confirmation: 'new_password',
          name: 'My Computer',
          device_type: 'ios',
          device_token: 'token123'
        }
      end

      subject { described_class.new(params.merge(user: user)) }

      before do
        #
        # Api::EndAllUserSessions.new(user).execute
        #
        expect(Api::EndAllUserSessions).to receive(:new).with(user) do
          double.tap do |a|
            expect(a).to receive(:execute)
          end
        end
      end

      specify { expect(subject.save).to eq(true) }

      specify { expect { subject.save }.to change { user.authenticate('old_password') }.from(user).to(false) }

      specify { expect { subject.save }.to change { user.authenticate('new_password') }.from(false).to(user) }

      specify { expect { subject.save }.to change { user.sessions.first&.name }.to('My Computer') }

      specify { expect { subject.save }.to change { user.sessions.first&.device_type }.to('ios') }

      specify { expect { subject.save }.to change { user.sessions.first&.device_token }.to('token123') }
    end

    context 'when user password wrong' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      let(:params) do
        {
          old_password: 'wrong-password',
          password: 'new_password',
          password_confirmation: 'new_password'
        }
      end

      subject { described_class.new(params.merge(user: user)) }

      before { expect(Api::EndAllUserSessions).not_to receive(:new) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to change { subject.errors.messages }.from({}).to(old_password: ['Wrong password']) }
    end

    context "when new user password doesn't match confirmation" do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      let(:params) do
        {
          old_password: 'password',
          password: 'new_password',
          password_confirmation: 'wrong-new-password'
        }
      end

      subject { described_class.new(params.merge(user: user)) }

      before { expect(Api::EndAllUserSessions).not_to receive(:new) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to change { subject.errors.messages }.from({}).to(password_confirmation: ["doesn't match Password"]) }
    end
  end
end

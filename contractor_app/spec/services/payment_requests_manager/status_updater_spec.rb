require 'rails_helper'

describe PaymentRequestsManager::StatusUpdater, type: :service do
  describe '.call' do
    let(:id) { double }
    let(:decided_at) { DateTime.current }
    subject(:status_updater_call) { described_class.call(id, { 'status' => 'accepted', 'decided_at' => decided_at }) }

    it 'logs error when cannot find payment request' do
      allow(PaymentRequest).to receive(:find).with(id).and_raise(ActiveRecord::RecordNotFound, 'Not found')

      expect(Rails.logger).to receive(:error).with('Not found')
      status_updater_call
    end

    context 'when payment request exists' do
      let(:payment_request) { create(:payment_request) }
      let(:id) { payment_request.id }

      it 'changes status and sets decision date' do
        status_updater_call
        payment_request.reload
        expect(payment_request.status).to eq('accepted')
        expect(payment_request.decided_at.to_i).to eq(decided_at.to_i)
      end

      context 'when payment request exists but was already rejected' do
        let(:payment_request) { create(:payment_request, :rejected) }

        it 'changes status and sets decision date' do
          status_updater_call
          payment_request.reload
          expect(payment_request.status).to eq('rejected')
        end
      end
    end
  end
end

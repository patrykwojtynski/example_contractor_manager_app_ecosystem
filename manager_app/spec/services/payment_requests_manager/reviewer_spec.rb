require 'rails_helper'

describe PaymentRequestsManager::Reviewer, type: :service do
  describe '.call' do
    let(:payment_request) { create(:payment_request) }

    subject(:reviewer_call) { described_class.call(payment_request, 'accepted') }

    it 'changes status' do
      reviewer_call
      expect(payment_request.status).to eq('accepted')
      expect(payment_request.decided_at).to_not be_blank
    end

    it 'returns true' do
      expect(reviewer_call).to be_truthy
    end

    context 'when decision was already made' do
      let(:payment_request) { create(:payment_request, :accepted) }

      it 'returns false' do
        expect(reviewer_call).to be_falsey
      end
    end
  end
end

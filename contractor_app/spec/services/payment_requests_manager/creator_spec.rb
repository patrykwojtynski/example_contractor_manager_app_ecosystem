require 'rails_helper'

describe PaymentRequestsManager::Creator, type: :service do
  describe '.call' do
    let(:params) { double }
    subject(:creator_call) { described_class.call(params) }
    let(:payment_request) { build(:payment_request) }

    before do
      allow(PaymentRequestsManager::Notifier).to receive(:call)
      allow(PaymentRequest).to receive(:create).with(params).and_return(payment_request)
    end

    it 'calls notifier' do
      expect(PaymentRequestsManager::Notifier).to receive(:call).with(payment_request)
      creator_call
    end

    it 'return payment request' do
      expect(creator_call).to eq(payment_request)
    end

    context 'when cannot save' do
      before do
        payment_request.errors.add(:field, 'error')
      end

      it 'does not call notifier' do
        expect(PaymentRequestsManager::Notifier).to_not receive(:call)
        creator_call
      end
    end
  end
end

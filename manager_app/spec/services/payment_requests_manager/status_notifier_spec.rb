require 'rails_helper'

describe PaymentRequestsManager::StatusNotifier, type: :service do
  describe '.call' do
    let(:payment_request) { create(:payment_request) }
    subject(:status_notifier_call) { described_class.call(payment_request) }

    before { status_notifier_call }

    it 'doesnt notify pending' do
      expect(karafka.produced_messages.size).to eq(0)
    end

    context 'when accepted' do
      let(:payment_request) { create(:payment_request, :accepted) }

      it { expect(karafka.produced_messages.last[:topic]).to eq('payment_request_statuses') }
      it { expect(karafka.produced_messages.last[:key]).to eq(payment_request.remote_id.to_s) }

      it 'produces correct payload' do
        json_payload = karafka.produced_messages.last[:payload]
        payload = JSON.parse(json_payload)
        expect(payload).to include(
          "id" => payment_request.remote_id,
          "status" => 'accepted',
          "decided_at" => payment_request.decided_at.as_json
        )
      end
    end
  end
end

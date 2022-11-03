require 'rails_helper'

describe PaymentRequestsManager::Notifier, type: :service do
  describe '.call' do
    # IDEA: good place to use fabricators
    let(:payment_request) { PaymentRequest.create(amount_cents: 111, amount_currency: 'PLN', description: 'Desc') }
    subject(:notifier_call) { described_class.call(payment_request) }

    before { notifier_call }

    it { expect(karafka.produced_messages.size).to eq(1) }
    it { expect(karafka.produced_messages.last[:topic]).to eq('payment_requests') }
    it { expect(karafka.produced_messages.last[:key]).to eq(payment_request.id.to_s) }

    it 'produces correct payload' do
      json_payload = karafka.produced_messages.last[:payload]
      payload = JSON.parse(json_payload)
      expect(payload).to include(
        "id" => payment_request.id,
        "amount_cents" => 111,
        "amount_currency" => "PLN",
        "description" => 'Desc',
        "created_at" => payment_request.created_at.as_json
      )
    end
  end
end

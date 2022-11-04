require 'rails_helper'

describe PaymentRequestsConsumer do
  subject(:consumer) { karafka.consumer_for('payment_requests') }

  before do
    karafka.produce({val: 'val'}.to_json, key: '1')
  end

  it 'calls creator' do
    expect(PaymentRequestsManager::Creator).to receive(:call).with('1', {'val' => 'val'})
    consumer.consume
  end
end

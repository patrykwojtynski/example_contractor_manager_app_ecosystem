require 'rails_helper'

describe PaymentRequestsManager::Creator, type: :service do
  describe '.call' do
    subject(:creator_call) { described_class.call(1, {}.to_json) }

    it 'creates request' do
      expect { creator_call }.to change(PaymentRequest, :count).by(1)
    end

    context 'when already exist' do
      before do
        # TODO: use factory bot
        PaymentRequest.create(remote_id: 1)
      end

      it 'does not create same request' do
        expect { creator_call }.to_not change(PaymentRequest, :count)
      end
    end
  end
end

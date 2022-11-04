require 'rails_helper'

describe 'Payment Requests', type: :request do
  describe 'POST /payment_requests' do
    subject(:post_payment_request) { post('/payment_requests', params: { payment_request: { description: 'Desc' } }) }
    let(:payment_request) { build(:payment_request) }

    before do
      expected_params = ActionController::Parameters.new({ description: 'Desc' }).permit!
      allow(PaymentRequestsManager::Creator)
        .to receive(:call).with(expected_params).and_return(payment_request)
    end

    it 'redirects to index' do
      post_payment_request
      expect(response).to redirect_to(payment_requests_url)
    end

    context 'when there are errors' do
      before { payment_request.errors.add(:field, 'error') }

      it 'renders to index' do
        post_payment_request
        expect(response).to render_template('payment_requests/new')
      end
    end
  end
end

require 'rails_helper'

describe 'Payment Requests', type: :request do
  describe 'GET /payment_requests/:id/accept' do
    let(:payment_request) { create(:payment_request) }
    subject(:accept) { get("/payment_requests/#{payment_request.id}/accept") }
    let(:success) { true }

    before do
      allow(PaymentRequestsManager::Reviewer)
        .to receive(:call).with(payment_request, 'accepted').and_return(success)
    end

    it 'redirects to index' do
      accept
      expect(flash[:notice]).to eq('Status has been changed')
      expect(response).to redirect_to(payment_requests_url)
    end

    context 'when it was unsuccessful' do
      let(:success) { false }

      it 'redirects to index' do
        accept
        expect(flash[:alert]).to eq('Something went wrong')
        expect(response).to redirect_to(payment_requests_url)
      end
    end
  end
end

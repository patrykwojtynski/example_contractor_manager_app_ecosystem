class PaymentRequestsController < ApplicationController
  def index
    @payment_requests = PaymentRequest.all.order(created_at: :desc)
  end

  def accept
    decide('accepted')
    redirect_to payment_requests_url
  end

  def reject
    decide('rejected')
    redirect_to payment_requests_url
  end

  private

    def payment_request
      PaymentRequest.find(params[:id])
    end

    def decide(decision)
      if PaymentRequestsManager::Reviewer.call(payment_request, decision)
        flash[:notice] = 'Status has been changed'
      else
        flash[:alert] = 'Something went wrong'
      end
    end
end

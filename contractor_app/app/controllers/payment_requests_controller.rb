class PaymentRequestsController < ApplicationController
  def index
    @payment_requests = PaymentRequest.all.order(created_at: :desc)
  end

  def new
    @payment_request = PaymentRequest.new
  end

  def create
    @payment_request = PaymentRequestsManager::Creator.call(payment_request_params)

    if @payment_request.errors.empty?
      redirect_to payment_requests_url, notice: "Payment request was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def payment_request_params
      params.fetch(:payment_request, {}).permit(:amount_cents, :amount_currency, :description)
    end
end

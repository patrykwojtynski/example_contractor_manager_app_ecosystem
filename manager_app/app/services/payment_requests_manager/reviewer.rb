module PaymentRequestsManager
  class Reviewer < ApplicationService
    def initialize(payment_request, decision)
      @payment_request = payment_request
      @decision = decision
    end

    def call
      return false unless @payment_request.status_pending?
      update
    end

    private

    def update
      @payment_request.update(status: @decision, decided_at: DateTime.current)
    end
  end
end

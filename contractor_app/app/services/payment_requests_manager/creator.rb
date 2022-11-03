module PaymentRequestsManager
  class Creator < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      create.tap do |payment_request|
        notify(payment_request) if payment_request.errors.empty?
      end
    end

    private

    def create
      PaymentRequest.create(@params)
    end

    def notify(payment_request)
      Notifier.call(payment_request)
    end
  end
end

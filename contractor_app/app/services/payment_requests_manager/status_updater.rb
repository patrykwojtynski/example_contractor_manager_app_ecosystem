module PaymentRequestsManager
  class StatusUpdater < ApplicationService
    def initialize(id, payload)
      @id = id
      @payload = payload
    end

    def call
      payment_request = PaymentRequest.find(@id)
      payment_request.update!(status: status, decided_at: decided_at) if payment_request.status_pending?
    rescue ActiveRecord::RecordNotFound => ex
      Rails.logger.error(ex.message)
    end

    private

    def status
      @payload['status']
    end

    def decided_at
      @payload['decided_at']
    end
  end
end

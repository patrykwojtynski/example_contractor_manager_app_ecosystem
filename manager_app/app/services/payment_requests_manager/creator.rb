module PaymentRequestsManager
  class Creator < ApplicationService
    def initialize(remote_id, payload)
      @remote_id = remote_id
      @payload = payload
    end

    def call
      PaymentRequest.where(remote_id: @remote_id).first_or_initialize(payload: @payload).save
    end
  end
end
